//
//  FirebaseStorageService.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseFirestore
import UIKit

enum FirebaseStorageServiceReferences: String {
    case moods = "User-Moods"
    case user = "User"
    case history = "History"
}

protocol FirebaseStorageServiceProtocol: AnyObject {
    func createNewUser(userModel: User)
    func getChartsData() -> AnyPublisher<[ChartModel], Error>
    func uploadNewUserMood(mood: ClassifiedMood)
//    func createUserStatistics()
//    func getUserStatistics() -> AnyPublisher<[User], Error>
    func getUserModel() -> AnyPublisher<User, Error>
    func updateUserFinishingDate(with date: Date)
    func addRecordToUserHistory(record: UserHistoryModel)
    func updateUserProfilePic(with: Data)
    func getUserHistory() -> AnyPublisher<[UserHistoryModel], Error>
//    var userPublisher: CurrentValueSubject<User?, Error> {get}
}

final class FirebaseStorageService: FirebaseStorageServiceProtocol {
    
    var cancellables = Set<AnyCancellable>()
    
    var userPublisher = CurrentValueSubject<User?, Error>(nil)
    
    private lazy var userId: String? = {
        let id = UserDefaults.standard.string(forKey: UserDefaultsConstants.userId)
        return id
    }()
    
    func uploadNewUserMood(mood: ClassifiedMood) {
        UserDefaults.standard.setValue(Date.now, forKey: UserDefaultsConstants.latestDayOfClassification)
        guard let userId else { return }
        let reference = getChildReference(for: .moods).child(userId).childByAutoId()
        let key = reference.key!
        let mood = ChartModel(id: key, classification: mood)
        try? reference.setValue(from: mood)
    }
    
    func getChildReference(for path: FirebaseStorageServiceReferences) -> DatabaseReference {
        return Database.database().reference(withPath: path.rawValue)
    }
    
    func getChartsData() -> AnyPublisher<[ChartModel], Error> {
        let reference = getChildReference(for: .moods).child(userId!)
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
    
    func getUserStatistics() -> AnyPublisher<User, Error> {
        let reference = getChildReference(for: .user).child(userId!)
        let subject = PassthroughSubject<User, Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let data = snapshot.value as? DataSnapshot {
                let user = try? data.data(as: User.self)
                if let user = user {
                    subject.send(user)
                }
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func createNewUser(userModel: User) {
        let reference = getChildReference(for: .user).child(userId!)
        try? reference.setValue(from: userModel)
    }
    
    func updateUserFinishingDate(with date: Date) {
        // Interestingly enough either firebase or apple uses 2001 timeinterval in codable rather than 1970
        let dateFormatted = date.timeIntervalSinceReferenceDate
        
        let reference = getChildReference(for: .user).child(userId!)
        reference.updateChildValues(["finishingDate" : Int(dateFormatted)])
    }
    
    func getUserModel() -> AnyPublisher<User, Error> {
        let reference = getChildReference(for: .user).child(userId!)
        let subject = PassthroughSubject<User, Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if (snapshot.value as Any?) != nil {
                let user = try? snapshot.data(as: User.self)
                if let user = user {
//                    self?.userPublisher.send(user)
                    subject.send(user)
                }
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func getUserHistory() -> AnyPublisher<[UserHistoryModel], Error> {
        let reference = getChildReference(for: .history).child(userId!)
        let subject = PassthroughSubject<[UserHistoryModel], Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let dataForCharts = children.compactMap { snapshot in
                    try? snapshot.data(as: UserHistoryModel.self)
                }
//                print("Data for charts \(dataForCharts)")
                subject.send(dataForCharts)
            }
            
        }
        return subject.eraseToAnyPublisher()
    }
    
    func addRecordToUserHistory(record: UserHistoryModel) {
        let reference = getChildReference(for: .history).child(userId!).childByAutoId()
       try? reference.setValue(from: record)
    }
    
    func updateUserProfilePic(with image: Data) {
        let reference = getChildReference(for: .user).child(userId!)
        let imageInString = image.base64EncodedString()
        reference.updateChildValues(["profileImage": imageInString])
    }
    
    deinit {
        print("\(self) deinited")
    }
}
