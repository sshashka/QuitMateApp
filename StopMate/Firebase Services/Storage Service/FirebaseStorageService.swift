//
//  FirebaseStorageService.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseStorage

//import UIKit

enum FirebaseStorageServiceReferences: String {
    case moods = "User-Moods"
    case user = "User"
    case history = "History"
    case moodDates = "User-Moods-Dates"
}

protocol FirebaseStorageServicePublishersProtocol: AnyObject {
    var userDataPublisher: CurrentValueSubject<User?, Error> { get }
    var userProfilePicturePublisher: CurrentValueSubject<Data?, Error> { get }
    var userMoodDates: CurrentValueSubject<Date?, Error> { get }
    
}

protocol FirebaseStorageServiceProtocol: FirebaseStorageServicePublishersProtocol {
    func createNewUser(userModel: User)
    func getChartsData() -> AnyPublisher<[ChartModel], Error>
    func uploadNewUserMood(mood: ClassifiedMood)
    func getUserModel()
    func updateUserFinishingDate(with date: Date)
    func addRecordToUserHistory(record: UserHistoryModel)
    func updateUserProfilePic(with: Data)
    func getUserHistory() -> AnyPublisher<[UserHistoryModel], Error>
    func updateUserProfileData(user: User)
    func checkIfUserExists(completion: @escaping(Bool) -> Void)
    func retrieveUserProfilePic()
    func updateUserOnboardingStatus()
}

final class FirebaseStorageService: FirebaseStorageServiceProtocol {
    var userProfilePicturePublisher = CurrentValueSubject<Data?, Error>(nil)
    
    var cancellables = Set<AnyCancellable>()
    
    var userDataPublisher = CurrentValueSubject<User?, Error>(nil)
    
    var userMoodDates = CurrentValueSubject<Date?, Error>(nil)
    
    // MARK: getting Child references
    private lazy var userId: String? = {
        let id = UserDefaults.standard.string(forKey: UserDefaultsConstants.userId)
        return id
    }()
    
    private func getChildReference(for path: FirebaseStorageServiceReferences) -> DatabaseReference {
        return Database.database().reference(withPath: path.rawValue)
    }
    
    private func getChildReferenceWithUserId(for path: FirebaseStorageServiceReferences) -> DatabaseReference {
        if let userId {
            return getChildReference(for: path).child(userId)
        }
        return DatabaseReference()
    }
    
    private func getReferenceForUserProfilePicture() -> StorageReference? {
        if let userId {
            return Storage.storage().reference().child(userId)
        }
        return nil
    }
    // MARK: Getiing user moods and charts
    func uploadNewUserMood(mood: ClassifiedMood) {
        guard let userId else { return }
        let reference = getChildReference(for: .moods).child(userId).childByAutoId()
        let key = reference.key!
        let mood = ChartModel(id: key, classification: mood)
        try? reference.setValue(from: mood)
    }
    
    
    func getChartsData() -> AnyPublisher<[ChartModel], Error> {
        let reference = getChildReferenceWithUserId(for: .moods)
        let subject = PassthroughSubject<[ChartModel], Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let dataForCharts = children.compactMap { snapshot in
                    try? snapshot.data(as: ChartModel.self)
                }
                subject.send(dataForCharts)
            }
            
        }
        return subject.eraseToAnyPublisher()
    }
    // MARK: Working with user-related data
    func createNewUser(userModel: User) {
        let reference = getChildReferenceWithUserId(for: .user)
        try? reference.setValue(from: userModel)
    }
    
    func updateUserFinishingDate(with date: Date) {
        // Interestingly enough either firebase or apple uses 2001 timeinterval in codable rather than 1970
        let dateFormatted = date.timeIntervalSinceReferenceDate
        
        let reference = getChildReferenceWithUserId(for: .user)
        reference.updateChildValues(["finishingDate" : Int(dateFormatted)])
    }
    
    func getUserModel() {
        let reference = getChildReferenceWithUserId(for: .user)
        reference.observe(.value) {[weak self] snapshot, error in
            if let error = error {
                self?.userDataPublisher.send(completion: .failure(error as! Error))
            } else if (snapshot.value as Any?) != nil {
                let user = try? snapshot.data(as: User.self)
                if let user = user {
                    self?.userDataPublisher.send(user)
                }
            }
        }
    }
    
    
    func updateUserProfilePic(with image: Data) {
        let reference = getReferenceForUserProfilePicture()
        guard let reference else { return }
        let imageCompressed = image.compressImage(maxSizeMB: 3)
        let uploadTask = reference.putData(imageCompressed ?? Data())
        uploadTask.observe(.success) { [weak self] _ in
            self?.retrieveUserProfilePic()
        }
    }
    
    func retrieveUserProfilePic() {
        let reference = getReferenceForUserProfilePicture()
        guard let reference else { return }
        reference.getData(maxSize: 3 * 1024 * 1024) {[weak self] data, error in
            if let error = error {
                self?.userProfilePicturePublisher.send(completion: .failure(error))
            } else {
                self?.userProfilePicturePublisher.send(data)
            }
        }
        
    }
    
    func updateUserProfileData(user: User) {
        let reference = getChildReferenceWithUserId(for: .user)
        reference.updateChildValues(user.toDictionary())
        
    }
    
    func updateUserOnboardingStatus() {
        let reference = getChildReferenceWithUserId(for: .user)
        reference.updateChildValues(["didCompleteTutorial" : true])
    }
    
    // MARK: Working with user history of recomendations
    func getUserHistory() -> AnyPublisher<[UserHistoryModel], Error> {
        let reference = getChildReferenceWithUserId(for: .history)
        let subject = PassthroughSubject<[UserHistoryModel], Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let dataForCharts = children.compactMap { snapshot in
                    try? snapshot.data(as: UserHistoryModel.self)
                }

                subject.send(dataForCharts)
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func addRecordToUserHistory(record: UserHistoryModel) {
        let reference = getChildReferenceWithUserId(for: .history).childByAutoId()
        try? reference.setValue(from: record)
    }
    // MARK: Checing if user exists
    func checkIfUserExists(completion: @escaping(Bool) -> Void) {
        let reference = getChildReferenceWithUserId(for: .user)
        reference.observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func checkIfUserCompletedOnboarding(completion: @escaping(Bool) -> Void) {
        let reference = getChildReferenceWithUserId(for: .user)
        reference.observeSingleEvent(of: .value) { snapshot in
            let user = try? snapshot.data(as: User.self)
            if let user {
                completion(user.didCompleteTutorial)
            }
        }
    }
    
    deinit {
        print("\(self) deinited")
    }
}
