//
//  AuthentificationViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.06.2023.
//

import SwiftUI
import Combine

final class AuthentificationViewModel: ObservableObject {
    enum AuthentificationViewModelStates {
        case idle, loading
    }
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailTextFieldColor: Color? = Color(ColorConstants.gray)
    @Published var passwordTextFieldColor: Color? = Color(ColorConstants.gray)
    @Published var loginButtonDisabled: Bool = true
    @Published var isShowingAlert: Bool = false
    @Published var passwordResetIsEnabled = false
    @Published var state: AuthentificationViewModelStates = .idle
    
    var error: String = ""
    
    let authentificationService: AuthentificationServiceProtocol!
    var didSendEventClosure: ((AuthentificationViewModel.EventType) -> Void)?
    
    init(authentificationService: AuthentificationServiceProtocol) {
        self.authentificationService = authentificationService
        setupPiplines()
    }
    
    private func setupPiplines() {
        // Add a check if fields are not empty + Make a static class that just combines checks
        formIsValid.assign(to: &$loginButtonDisabled)
        
        emailIsValid.mapToFieldInputColor()
            .assign(to: &$emailTextFieldColor)
        
        passwordIsValid.mapToFieldInputColor()
            .assign(to: &$passwordTextFieldColor)
        
        emailIsValid.assign(to: &$passwordResetIsEnabled)
    }
    // Create statics in class called validation
    private var emailIsValid: AnyPublisher<Bool, Never> {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return $email
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map {
                emailPredicate.evaluate(with: $0)
            }
            .eraseToAnyPublisher()
    }
    
    
    private var passwordIsValid: AnyPublisher<Bool, Never> {
        let passwordRegex = "^.{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return $password
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map {
                passwordPredicate.evaluate(with: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private var formIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(emailIsValid, passwordIsValid)
            .map {
                $0 && $1
            }
            .eraseToAnyPublisher()
    }
    
    func didTapOnRegister() {
        self.didSendEventClosure?(.regiser)
    }
    
    func didTapOnLogin() {
        state = .loading
        authentificationService.didSelectLoginWithEmailLogin(email: email, password: password) {[weak self] result in
            switch result {
            case .success:
                self?.didSendEventClosure?(.login)
            case .failure(let string):
                self?.state = .idle
                self?.isShowingAlert = true
                self?.error = string
            }
        }
    }
    
    func didTapOnForgotPassword() {
        guard !email.isEmpty else { return }
        authentificationService.resetPasswordForNotAuthentoficatedUser(email: email)
        isShowingAlert = true
        error = "Email with instructions has been sent"
    }
}

extension AuthentificationViewModel {
    enum EventType {
        case login
        case regiser
        case passwordReset
    }
}



