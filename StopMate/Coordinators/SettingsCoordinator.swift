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

class SettingsCoordinator: NSObject, SettingsCoordinatorProtocol {
    
    lazy var storageService: FirebaseStorageServiceProtocol = {
        return FirebaseStorageService()
    }()
    
    lazy var authService: AuthentificationServiceProtocol = {
        return FirebaseAuthentificationService()
    }()
    
    var didSendEventClosure: ((Coordinator) -> Void)?
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .settings }
    
    func start() {
        navigationController.delegate = self
        showSettings()
        storageService.getUserModel()
        storageService.retrieveUserProfilePic()
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
//        navigationController.title = "Settings"
    }
    
    private func showHistory() {
        let vm = UserHistoryViewModel(storageService: storageService)
        let vc = UIHostingController(rootView: UserHistoryView(viewModel: vm))
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func didTapOnEdit() {
        let vm = EditProfileViewModel(storageService: storageService)
        let vc = UIHostingController(rootView: EditProfileView(viewModel: vm))
        navigationController.pushViewController(vc, animated: true)
        vm.didSendEventClosure = { [weak self] _ in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
    deinit {
        navigationController.delegate = nil
        print("\(self) deinited")
    }
}

extension SettingsCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let currentVC = fromViewController as? SettingsViewController {
            // We're popping a buy view controller; end its coordinator
            didSendEventClosure?(self)
        }
    }
}
