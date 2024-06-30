//
//  OnboardingCoordinator.swift
//  StopMate
//
//  Created by Саша Василенко on 16.08.2023.
//

import UIKit
import SwiftUI

protocol OnboardingCoordinatorProtocol: Coordinator {
    func start()
}

final class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    private let storageService = FirebaseStorageService()
    
    var container: AppContainer
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .onboarding }
    
    required init (_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let onboardingModule = OnboardingViewBuilder.build(container: container)
        onboardingModule.viewModel.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }
        navigationController.pushWithCustomAnination(onboardingModule.viewController)
    }
}
