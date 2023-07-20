//
//  SettingsCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.07.2023.
//

import UIKit
import SwiftUI

protocol SettingsCoordinatorProtocol: Coordinator {
    func showSettings()
}

class SettingsCoordinator: SettingsCoordinatorProtocol {
    
    lazy var storageService: FirebaseStorageServiceProtocol = {
        return FirebaseStorageService()
    }()
    
    lazy var authService: AuthentificationServiceProtocol = {
        return FirebaseAuthentificationService()
    }()
    
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
        let vm = SettingsViewModel(storageService: storageService, authService: authService)
        
        vm.didSendEventClosure = { [weak self] event in
            switch event {
            case .didTapOnNewMood:
                self?.replaceWithNewCoordinator(coordinator: .moodClassifier)
            case .didTapOnHistory:
                self?.showHistory()
            case .didTapOnEdit:
                self?.didTapOnEdit()
            }
        }
        let vc = SettingsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showHistory() {
        let vc = UIHostingController(rootView: UserHistoryView())
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func didTapOnEdit() {
        let vm = EditProfileViewModel(storageService: storageService)
        let vc = UIHostingController(rootView: EditProfileView(viewModel: vm))
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("\(self) deinited")
    }
}
