//
//  FirebaseStorageService.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Firebase

enum FirebaseStorageServiceReferences: String {
    case userStats = "User-Stats"
    case moods = "User-Moods"
    case user = "User"
}

class FirebaseStorageService {
    private var userId = UserDefaults.standard.string(forKey: "UserID")
    var cancellables = Set<AnyCancellable>()
    
    
    func uploadNewUserMood(mood: ClassifiedMood) {
        let reference = getChildReference(for: .moods).child(userId!).childByAutoId()
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
    
    func createUserStatistics() {
        let reference = getChildReference(for: .userStats).child(userId!).childByAutoId()
        let key = reference.key!
        let model = UserStatisticsModel(id: key, moneySpentOnSigs: 25.0, enviromentalChanges: 4)
        try? reference.setValue(from: model)
    }
    
    func getUserStatistics() -> AnyPublisher<[UserStatisticsModel], Error> {
        let reference = getChildReference(for: .userStats).child(userId!)
        let subject = PassthroughSubject<[UserStatisticsModel], Error>()
        
        reference.observe(.value) { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(error as! Error))
            } else if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let dataForCharts = children.compactMap { snapshot in
                    try? snapshot.data(as: UserStatisticsModel.self)
                }
                print(dataForCharts)
                subject.send(dataForCharts)
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    func createUser() {
        let image = UIImage(named: "Tokyo")?.pngData()
        let reference = getChildReference(for: .user).child(userId!).childByAutoId()
        let key = reference.key!
        let user = User(name: "Sasha", age: 21, email: "sshashkaov@gmail.com", id: key, profileImage: image)
        
        try? reference.setValue(from: user)
    }
    
    func getUserModel() -> AnyPublisher<[User], Error> {
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
