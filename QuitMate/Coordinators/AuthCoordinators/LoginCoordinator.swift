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
    private let authService = AuthentificationService()
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
        navigationController.pushViewController(authentificationVC, animated: true)
    }
    
    
    func showRegistrationView() {
        let registrationViewModel = RegistrationViewModel(authentificationService: authService)
        let registrationVC = UIHostingController(rootView: RegistrationView(viewModel: registrationViewModel))
        
        registrationViewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .done:
                self?.showFirstTimeEntryFlow()
            case .backToLogin:
                self?.navigationController.popToRootViewController(animated: true)
            }
        }
        navigationController.pushViewController(registrationVC, animated: true)
    }
    
    private func showFirstTimeEntryFlow() {
        let coordinator = FirstTimeEntryCoordinator(navigationController)
        coordinator.finishDelegate = finishDelegate
        childCoordinators.append(coordinator)
        coordinator.start()
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
    
    deinit {
        print("\(self) is deinited")
    }
}
