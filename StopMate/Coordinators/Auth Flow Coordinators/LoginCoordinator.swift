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
    private let authService = FirebaseAuthentificationService()
    internal func showAuthentificationViewController() {
        let vm = AuthentificationViewModel(authentificationService: authService)
        let authentificationVC = UIHostingController(rootView: AuthentificationView(viewModel: vm))
        vm.didSendEventClosure = { [weak self] event in
            switch event {
            case .login:
                self?.finish()
            case .passwordReset:
                print("reset")
            case .regiser:
                self?.showRegistrationView()
            }
        }
        navigationController.setViewControllersWithCustomAnimation([authentificationVC])
//        navigationController.pushWithCustomAnination(authentificationVC)
    }
    
    
    func showRegistrationView() {
        let registrationViewModel = RegistrationViewModel(authentificationService: authService)
        let registrationVC = UIHostingController(rootView: RegistrationView(viewModel: registrationViewModel))
        
        registrationViewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .done:
                // Since i already observe state I dont need to finish and instanciate new coordinator manualy
                
                assert(true)
            case .backToLogin:
                self?.navigationController.popToRootViewController(animated: true)
            }
        }
        navigationController.pushViewController(registrationVC, animated: true)
    }
    
    private func showFirstTimeEntryFlow() {
        finishDelegate?.instantiateNewCoordinator(coordinator: .firstTimeEntry)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .auth}
    
    func start() {
        showAuthentificationViewController()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
