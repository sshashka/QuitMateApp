//
//  RegisterCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 08.06.2023.
//

import SwiftUI

protocol FirstTimeEntryCoordinatorProtocol: Coordinator {
    func showRegisterScreen()
}

final class FirstTimeEntryCoordinator: FirstTimeEntryCoordinatorProtocol {
    internal func showRegisterScreen() {
        navigationController.viewControllers = []
        let storageService = FirebaseStorageService()
        let vm = FirstTimeEntryViewModel(authService: storageService)
        let vc = UIHostingController(rootView: FirstTimeEntryView(viewModel: vm))
        vm.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .register }
    
    func start() {
        showRegisterScreen()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) is deinited")
    }
    
}
