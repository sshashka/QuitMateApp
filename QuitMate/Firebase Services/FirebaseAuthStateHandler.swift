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

// Handle auth state change in realtime
class FirebaseAuthStateHandler {
    func checkIfUserIsAuthentificated(completion: @escaping(FirebaseAuthStateHandlerResult) -> Void) {
        Auth.auth().addStateDidChangeListener {auth, user in
            if user == nil {
                completion(.userIsNotAuthentificated)
            } else {
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "UserID")
                completion(.userIsAuthentificated)
            }
        }
    }
}
