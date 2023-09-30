//
//  RegistrationViewModule.swift
//  QuitMate
//
//  Created by Саша Василенко on 17.05.2023.
//


import Combine
import SwiftUI

enum RegistrationViewModelStates {
    case idle, loading
}

protocol RegistrationViewModelProtocol: AnyObject, ObservableObject {
    var state: RegistrationViewModelStates { get }
    var email: String { get set }
    var password: String { get set }
    var passwordConfirmation: String { get set }
    var registerButtonEnabled: Bool { get }
    var emailTextFieldColor: Color? { get }
    var passwordTextFieldColor: Color? { get }
    var passwordConfirmationTextFieldColor: Color? { get }
    var isShowingAlert: Bool { get set }
    var error: String { get }
    
    func didTapLoginButton()
    func didTapDoneButton()
}

final class RegistrationViewModel: ObservableObject, RegistrationViewModelProtocol {
    private let authentificationService: AuthentificationServiceProtocol
    var didSendEventClosure: ((RegistrationViewModel.EventType) -> Void)?
    
    @Published var state: RegistrationViewModelStates = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
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
        .eraseToAnyPublisher()
    }
    
    var passwordMatchesConfirmation: AnyPublisher<Bool, Never> {
        return $password.combineLatest($passwordConfirmation)
            .map { password, confirmation in
                if confirmation.isEmpty {
                    return false // Return false if confirmation is empty
                }
                return password == confirmation
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
        state = .loading
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
