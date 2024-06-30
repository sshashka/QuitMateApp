//
//  LoginCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.04.2023.
//

import UIKit
import SwiftUI

protocol LoginCoordinatorProtocol: Coordinator {
    func showAuthentificationViewController()
}


final class LoginCoordinator: LoginCoordinatorProtocol {
    var container: AppContainer
    
    required init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    private let authService = FirebaseAuthentificationService()
    internal func showAuthentificationViewController() {
        let authModule = AuthentificationViewBuilder.build(container: container)
        authModule.viewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .login:
                self?.finish()
            case .passwordReset:
                print("reset")
            case .regiser:
                self?.showRegistrationView()
            }
        }
        navigationController.setViewControllersWithCustomAnimation([authModule.viewController])
    }
    
    
    func showRegistrationView() {     
        let registrationModule = RegistrationViewBuilder.build(container: container)
        registrationModule.viewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .done:
                // Since i already observe state I dont need to finish and instanciate new coordinator manualy
                
                assert(true)
            case .backToLogin:
                self?.navigationController.popToRootViewController(animated: true)
            }
        }
        navigationController.pushViewController(registrationModule.viewController, animated: true)
    }
    
    private func showFirstTimeEntryFlow() {
        finishDelegate?.instantiateNewCoordinator(coordinator: .firstTimeEntry)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .auth }
    
    func start() {
        showAuthentificationViewController()
    }
}
