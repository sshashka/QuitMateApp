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
}
// Add an saving of userId if user logged in
class FirebaseAuthStateHandler {
    
    var userState = PassthroughSubject<FirebaseAuthStateHandlerResult, Never>()
    
    init() {
        checkIfUserIsAuthentificated()
    }
    
    func checkIfUserIsAuthentificated() {
        Auth.auth().addStateDidChangeListener {auth, user in
            if user == nil {
                self.userState.send(.userIsNotAuthentificated)
            } else {
                self.userState.send(.userIsAuthentificated)
            }
        }
    }
}
