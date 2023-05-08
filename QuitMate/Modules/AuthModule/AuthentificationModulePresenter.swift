//
//  AuthentificationModulePresenter.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.02.2023.
//

import Foundation

protocol AutentificationLoginViewControllerProtocol: AnyObject {
    func didReceiveErrorFromFirebaseAuth(error: String)
}

protocol AutentificationRegisterViewControllerProtocol: AnyObject {
    func didRegisterSuccesfully(message: String)
    func didReceieveError(error: String)
}

protocol AuthentificationModulePresenterProtocol: AnyObject {
    var didSendEventClosure: ((AuthentificationModulePresenter.EventType) -> Void)? {get set}
    func didSelectLoginWithEmailLogin(email: String, password: String)
    func didSelectRegisterWithEmailLogin(email: String, password: String)
}

final class AuthentificationModulePresenter: AuthentificationModulePresenterProtocol {
    var didSendEventClosure: ((AuthentificationModulePresenter.EventType) -> Void)?
    weak var LoginView: AutentificationLoginViewControllerProtocol?
    weak var registerView: AutentificationRegisterViewControllerProtocol?
    let authentificationService: AuthentificationServiceProtocol!
    
    init(view: AutentificationLoginViewControllerProtocol, authentificationService: AuthentificationServiceProtocol) {
        self.LoginView = view
        self.authentificationService = authentificationService
    }
    
    func didSelectLoginWithEmailLogin(email: String, password: String) {
        authentificationService.didSelectLoginWithEmailLogin(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.didSendEventClosure?(.authentification)
            case .failure(let reason):
                self?.LoginView?.didReceiveErrorFromFirebaseAuth(error: reason)
            }
        }
    }
    
    func didSelectRegisterWithEmailLogin(email: String, password: String) {
        authentificationService.didSelectRegisterWithEmailLogin(email: email, password: password) {[weak self] result in
            switch result {
            case .success:
                self?.registerView?.didRegisterSuccesfully(message: "You have successfully registered. Now tap login button to enter")
            case .failure(let reason):
                self?.registerView?.didReceieveError(error: reason)
            }
        }
    }
}

extension AuthentificationModulePresenter {
    enum EventType { case authentification }
}
