//
//  FirebaseStorageService.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import UIKit

enum FirebaseStorageServiceReferences: String {
    case moods = "User-Moods"
    case user = "User"
}

protocol FirebaseStorageServiceProtocol: AnyObject {
    func createNewUser(userModel: User)
    func getChartsData() -> AnyPublisher<[ChartModel], Error>
    func uploadNewUserMood(mood: ClassifiedMood)
    func createUserStatistics()
    func getUserStatistics() -> AnyPublisher<[User], Error>
    func getUserModel() -> AnyPublisher<[User], Error>
}

class FirebaseStorageService: FirebaseStorageServiceProtocol {
    
    var cancellables = Set<AnyCancellable>()
    
    
    func uploadNewUserMood(mood: ClassifiedMood) {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
        let reference = getChildReference(for: .moods).child(userId!).childByAutoId()
        let key = reference.key!
        let mood = ChartModel(id: key, classification: mood)
        try? reference.setValue(from: mood)
    }
    
    func getChildReference(for path: FirebaseStorageServiceReferences) -> DatabaseReference {
        return Database.database().reference(withPath: path.rawValue)
    }
    
    func getChartsData() -> AnyPublisher<[ChartModel], Error> {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
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
    
    func createUserStatistics() {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
        let reference = getChildReference(for: .user).child(userId!).childByAutoId()
        let key = reference.key!
        let model = UserStatisticsModel(id: key, moneySpentOnSigs: 25.0, enviromentalChanges: 4)
        try? reference.setValue(from: model)
    }
    
    func getUserStatistics() -> AnyPublisher<[User], Error> {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
        let reference = getChildReference(for: .user).child(userId!)
        let subject = PassthroughSubject<[User], Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let dataForCharts = children.compactMap { snapshot in
                    try? snapshot.data(as: User.self)
                }
                print(dataForCharts)
                subject.send(dataForCharts)
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func createNewUser(userModel: User) {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
        let reference = getChildReference(for: .user).child(userId!).childByAutoId()
        print(userId)
        let key = reference.key!
        try? reference.setValue(from: userModel)
    }
    
    func getUserModel() -> AnyPublisher<[User], Error> {
        // Костыль
        var userId = UserDefaults.standard.string(forKey: "UserID")
        let reference = getChildReference(for: .user).child(userId!)
        let subject = PassthroughSubject<[User], Error>()
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let data = children.compactMap { snapshot in
                    try? snapshot.data(as: User.self)
                }
                subject.send(data)
                print(data)
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    deinit {
        print("\(self) deinited")
    }
}
