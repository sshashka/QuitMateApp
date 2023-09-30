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
        let storageService = FirebaseStorageService()
        let vm = FirstTimeEntryViewModel(storageService: storageService)
        let vc = UIHostingController(rootView: FirstTimeEntryView(viewModel: vm))
        vm.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushWithCustomAnination(vc)
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .firstTimeEntry }
    
    func start() {
        showRegisterScreen()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
