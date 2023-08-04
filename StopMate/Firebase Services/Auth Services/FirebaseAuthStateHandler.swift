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
}

// Handle auth state change in realtime
final class FirebaseAuthStateHandler {
    private let storageService = FirebaseStorageService()
    private var disposeBag = Set<AnyCancellable>()
        
    func checkIfUserIsAuthentificated() -> AnyPublisher<FirebaseAuthStateHandlerResult, Never> {
        let publisher = PassthroughSubject<FirebaseAuthStateHandlerResult, Never>()
        Auth.auth().addStateDidChangeListener {[weak self] auth, user in
            if user == nil {
                publisher.send(.userIsNotAuthentificated)
            } else {
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: UserDefaultsConstants.userId)
                self?.storageService.checkIfUserExists { status in
                    if status == true {
                        publisher.send(.userIsAuthentificated)
                    } else {
                        publisher.send(.userNeedsToCompleteRegistration)
                    }
                }
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    deinit {
        print("\(self) deinited")
    }
}
