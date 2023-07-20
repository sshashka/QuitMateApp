//
//  CoreMLClassifierViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.05.2023.
//

import UIKit

protocol CoreMLClassifierCoordinatorProtocol: Coordinator {
    func showCoreMLClassifier()
}

final class CoreMLClassifierCoordinator: CoreMLClassifierCoordinatorProtocol {
    internal func showCoreMLClassifier() {
        let vc = MoodClassifierViewController.module
        vc.presenter?.didSendEventClosure = { [weak self] event in
            switch event {
            case .done:
                self?.showRecomendations()
            case .switchToManualClassifier:
                self?.navigationController.popToRootViewController(animated: true)
            }
            
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.moodClassifier}
    
    func start() {
        showCoreMLClassifier()
    }
    
    private func showRecomendations() {
        let coordinator = RecomendationsCoordinator(navigationController)
        coordinator.finishDelegate = finishDelegate
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
