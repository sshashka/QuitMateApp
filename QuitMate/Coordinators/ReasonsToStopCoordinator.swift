//
//  ReasonsToStopCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.05.2023.
//

import UIKit
import SwiftUI
protocol ReasonsToStopCoordinatorProtocol: Coordinator {
    func showReasonsToStop()
}

final class ReasonsToStopCoordinator: ReasonsToStopCoordinatorProtocol {
    func showReasonsToStop() {
        self.navigationController.tabBarController?.tabBar.isHidden = true
        let vc = ReasonsToStopViewController.module
        vc.presenter?.didSendEventClosure = { [weak self] event in
            self?.showFinishingDate()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFinishingDate() {
        let vm = ReasonsToStopNewFinishingDateViewModel(storageService: FirebaseStorageService())
        let vc = UIHostingController(rootView: ReasonsToStopNewFinishingDateView(viewModel: vm))
        
        vm.didSendEventClosure = { [weak self] event in
            self?.showRecomendations()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showRecomendations() {
        let recomendationsCoordinator = RecomendationsCoordinator(navigationController)
        recomendationsCoordinator.recomendationType = .smoking
        recomendationsCoordinator.finishDelegate = finishDelegate
        childCoordinators.append(recomendationsCoordinator)
        recomendationsCoordinator.start()
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .reasonsToStop }
    
    func start() {
        showReasonsToStop()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
