//
//  RegistrationViewModule.swift
//  QuitMate
//
//  Created by Саша Василенко on 17.05.2023.
//

import Foundation
import Combine
import UIKit

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationPassword: String = ""
    
    @Published var registerButtonEnabled: Bool = false
    @Published var emailTextFieldColor: UIColor?
    @Published var passwordTextFieldColor: UIColor?
    @Published var passwordConfirmationTextFieldColor: UIColor?
    
    init() {
        setupPiplines()
    }
    
    private func setupPiplines() {
        formIsValid.assign(to: &$registerButtonEnabled)
        emailIsValid.mapToFieldInputColor()
            .assign(to: &$emailTextFieldColor)
        
        passwordIsValid.mapToFieldInputColor()
            .assign(to: &$passwordTextFieldColor)
        
        passwordMatchesConfirmation.mapToFieldInputColor()
            .assign(to: &$passwordConfirmationTextFieldColor)
    }
    
    var emailIsValid: AnyPublisher<Bool, Never> {
        $email.map {
            $0.contains("@") && $0.contains(".")
        }
        .eraseToAnyPublisher()
    }
    
    
    var passwordIsValid: AnyPublisher<Bool, Never> {
        $password.map {
            $0.count >= 8
        }
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
    var passwordMatchesConfirmation: AnyPublisher<Bool, Never> {
        $password.combineLatest($confirmationPassword)
            .map {
                $0 == $1
            }.eraseToAnyPublisher()
    }
    
    var passwordIsValidAndConfirmed: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(passwordIsValid, passwordMatchesConfirmation)
            .map {
                $0 && $1
            }
            .eraseToAnyPublisher()
    }
    
    var formIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(emailIsValid, passwordIsValidAndConfirmed)
            .map {
                $0 && $1
            }
            .eraseToAnyPublisher()
    }
    
    func didTapDoneButton() {
        AuthentificationService().didSelectRegisterWithEmailLogin(email: email, password: password) {
            switch $0 {
            case .success:
                print("SuckAss")
            case .failure(_):
                print("failure")
            }
        }
    }
}

extension Publisher where Output == Bool, Failure == Never {
    func mapToFieldInputColor() -> AnyPublisher<UIColor?, Never> {
        map { isValid -> UIColor? in
            isValid ? .systemGray : .systemRed
        }
        .eraseToAnyPublisher()
    }
}
