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
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .reasonsToStop }
    
    func start() {
        navigationController.setNavigationBarHidden(false, animated: true)
        showReasonsToStop()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) is deinited")
    }
    
    func showReasonsToStop() {
        let vc = ReasonsToStopViewController.module
        vc.presenter?.didSendEventClosure = { [weak self] event in
            self?.showFinishingDate()
        }
        navigationController.pushWithCustomAnination(vc)
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
}
