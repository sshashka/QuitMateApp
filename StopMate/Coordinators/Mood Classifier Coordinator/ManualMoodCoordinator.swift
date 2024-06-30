//
//  ManualMoodCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.05.2023.
//

import UIKit
import SwiftUI

protocol ManualMoodCoordinatorProtocol: Coordinator {
    func showManualSelectionView()
}

final class ManualMoodCoordinator: ManualMoodCoordinatorProtocol {
    var didSendEventClosure: ((CoordinatorType) -> Void)?
    
    var container: AppContainer
    
    func showManualSelectionView() {
        let module = MoodClassifierViewBuilder.build(contailer: container)
        let vc = module.viewController
        module.viewModel.didSendEndEventClosure = { [weak self] event in
            self?.showRecomendations()
        }
        navigationController.pushWithCustomAnination(vc)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.moodClassifier}
    
    private func showRecomendations() {
        let coordinator = RecomendationsCoordinator(navigationController, container: container)
        coordinator.finishDelegate = finishDelegate
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func start() {
        showManualSelectionView()
    }
    
    required init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
}
