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
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .onboarding }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = OnboardingViewModel(storageService: storageService)
        let vc = UIHostingController(rootView: OnboardingView(viewModel: vm))
        vm.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }
        navigationController.pushWithCustomAnination(vc)
    }
}
