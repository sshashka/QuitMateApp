//
//  SettingsCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.07.2023.
//

import UIKit

protocol SettingsCoordinatorProtocol: Coordinator {
    func showSettings()
}

class SettingsCoordinator: SettingsCoordinatorProtocol {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .settings }
    
    func start() {
        showSettings()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showSettings() {
        let storageService = FirebaseStorageService()
        let authService = FirebaseAuthentificationService()
        let vm = SettingsViewModel(storageService: storageService, authService: authService)
        
        vm.didSendEventClosure = { [weak self] event in
            switch event {
            case .didTapOnNewMood:
                self?.replaceWithNewCoordinator(coordinator: .moodClassifier)
            }
        }
        let vc = SettingsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("\(self) deinited")
    }
}
