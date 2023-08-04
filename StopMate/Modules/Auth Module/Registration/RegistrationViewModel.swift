//
//  RegistrationViewModule.swift
//  QuitMate
//
//  Created by Саша Василенко on 17.05.2023.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class RegistrationViewModel: ObservableObject {
    enum RegistrationViewModelStates {
        case idle, loading
    }
    private let authentificationService: AuthentificationServiceProtocol
    @Published var state: RegistrationViewModelStates = .idle
    var didSendEventClosure: ((RegistrationViewModel.EventType) -> Void)?
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmationPassword: String = ""
    
    @Published var registerButtonEnabled: Bool = false
    @Published var emailTextFieldColor: Color?
    @Published var passwordTextFieldColor: Color?
    @Published var passwordConfirmationTextFieldColor: Color?
    
    @Published var isShowingAlert: Bool = false
    @Published var error: String = ""
    
    init(authentificationService: AuthentificationServiceProtocol) {
        self.authentificationService = authentificationService
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
    
    func didTapLoginButton() {
        didSendEventClosure?(.backToLogin)
    }
    
    func didTapDoneButton() {
        
        authentificationService.didSelectRegisterWithEmailLogin(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.didSendEventClosure?(.done)
            case .failure(let error):
                self?.isShowingAlert = true
                self?.error = error
                self?.state = .idle
            }
        }
    }
}

extension RegistrationViewModel {
    enum EventType {
        case backToLogin
        case done
    }
}
