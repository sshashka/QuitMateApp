//
//  FirebaseAuthStateChecker.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.07.2023.
//

import FirebaseAuth
import Combine

enum FirebaseAuthStateHandlerResult {
    case userIsAuthentificated
    case userIsNotAuthentificated
    case userNeedsToCompleteRegistration
    case userDidNotCompleteOnboarding
}

protocol FirebaseAuthStateHandlerProtocol: AnyObject {
    func checkIfUserIsAuthentificated() -> AnyPublisher<FirebaseAuthStateHandlerResult, Never>
}

/// This class handles user authentification states
final class FirebaseAuthStateHandler: FirebaseAuthStateHandlerProtocol {
    private let storageService = FirebaseStorageService()
    private var disposeBag = Set<AnyCancellable>()
        
    func checkIfUserIsAuthentificated() -> AnyPublisher<FirebaseAuthStateHandlerResult, Never> {
        let publisher = PassthroughSubject<FirebaseAuthStateHandlerResult, Never>()
        Auth.auth().addStateDidChangeListener {[weak self] auth, user in
            if user == nil {
                publisher.send(.userIsNotAuthentificated)
            } else {
                let userId = Auth.auth().currentUser?.uid
                UserDefaults.standard.set(userId, forKey: UserDefaultsConstants.userId)
                self?.storageService.checkIfUserExists(userID: userId) { status in
                    if status == true {
                        self?.storageService.checkIfUserCompletedOnboarding { result in
                            switch result {
                            case true:
                                publisher.send(.userIsAuthentificated)
                            case false:
                                publisher.send(.userDidNotCompleteOnboarding)
                            }
                        }
                    } else {
                        publisher.send(.userNeedsToCompleteRegistration)
                    }
                }
            }
        }
        return publisher.eraseToAnyPublisher()
    }
}
