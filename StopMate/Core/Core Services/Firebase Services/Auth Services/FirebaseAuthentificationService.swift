//
//  AuthentificationService.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.02.2023.
//


// FIRAuthErrorCodeInvalidEmail    Indicates the email address is malformed.

//FIRAuthErrorCodeInvalidEmail    Indicates the email address is malformed.
//FIRAuthErrorCodeUserDisabled    Indicates the user's account is disabled.
//FIRAuthErrorCodeWrongPassword    Indicates the user attempted sign in with a wrong password.

// swiftlint:disable all 
//FIRAuthErrorCodeInvalidEmail    Indicates the email address is malformed.
//FIRAuthErrorCodeEmailAlreadyInUse    Indicates the email used to attempt sign up already exists. Call fetchProvidersForEmail to check which sign-in mechanisms such user used, and prompt the user to sign in with one of those.
//FIRAuthErrorCodeOperationNotAllowed    Indicates that email and password accounts are not enabled. Enable them in the Authentication section of the Firebase console.
//FIRAuthErrorCodeWeakPassword    Indicates an attempt to set a password that is considered too weak. The NSLocalizedFailureReasonErrorKey field in the NSError.userInfo dictionary object will contain more detailed explanation that can be shown to the user.

import Foundation
import FirebaseAuth
import Combine

enum ResultOfAuthentification {
    case success
    case failure(String)
}

protocol AuthentificationServiceProtocol: AnyObject {
    func didSelectLoginWithEmailLogin(email: String, password: String, completion: @escaping(ResultOfAuthentification) -> Void)
    func didSelectRegisterWithEmailLogin(email: String, password: String, completion: @escaping(ResultOfAuthentification) -> Void)
    func resetPassword()
    func resetPasswordForNotAuthentoficatedUser(email: String)
    func deleteAccount()
}

final class FirebaseAuthentificationService: AuthentificationServiceProtocol {
    
    func didSelectLoginWithEmailLogin(email: String, password: String, completion: @escaping(ResultOfAuthentification) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        completion(.failure("Oops... Looks like user with this email does not exist. Try again"))
                    case .invalidEmail:
                        completion(.failure("OOPS... your email looks wrong, try again"))
                    case .userDisabled:
                        completion(.failure("OOPS... user's account is disabled. Try creating a new one"))
                    case .wrongPassword:
                        completion(.failure("OOPS... looks like you have attempted to sign in with a wrong password."))
                    default:
                        completion(.failure("OOPS... looks like unknow error. Try again later"))
                    }
                }
            }
            else {
                // Костыль
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "UserID")
                completion(.success)
            }
        }
    }
    
    func didSelectRegisterWithEmailLogin(email: String, password: String, completion: @escaping(ResultOfAuthentification) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        completion(.failure("OOPS... looks like your email is already in use"))
                    case .invalidEmail:
                        completion(.failure("OOPS... your email looks wrong, try again"))
                    case .weakPassword:
                        completion(.failure("OOPS... looks like your password is too weak"))
                    default:
                        completion(.failure("OOPS... looks like unknow error. Try again later"))
                    }
                }
            } else {
                completion(.success)
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: UserDefaultsConstants.userId)
            }
        }
    }
    
    func resetPassword() {
        // Add a completion and error handling
        let email = Auth.auth().currentUser?.email
        guard let email else { return }
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func resetPasswordForNotAuthentoficatedUser(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func deleteAccount() {
        Auth.auth().currentUser?.delete()
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        } catch {
            print("Error Signing Out.")
        }
    }
}
