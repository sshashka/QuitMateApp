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
    var container: AppContainer
    
    init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .reasonsToStop }
    
    private var selectedReasons = [ReasonsToStop]()
    
    private var userStateMetrics: UserSmokingSessionMetrics?
    
    private let storageService = FirebaseStorageService()
    
    func start() {
        navigationController.setNavigationBarHidden(false, animated: true)
        showUserStateView()
    }
    
    func showReasonsToStop() {
        let vc = ReasonsToStopViewController.module
        vc.presenter?.didSendEventClosure = { [weak self] event in
            switch event {
            case .done(let reasons):
                self?.showFinishingDate()
                self?.selectedReasons = reasons
            }
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showUserStateView() {
        let module = UserEmotionalStateViewBuilder.build(container: container)
        module.viewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .done(let metrics):
                self?.showReasonsToStop()
                self?.userStateMetrics = metrics
            case .finish:
                self?.finishDelegate?.instantiateNewCoordinator(coordinator: .tabbar)
            }
        }
        navigationController.pushWithCustomAnination(module.viewController)
    }
    func showFinishingDate() {
        let module = ReasonsToStopNewFinishingDateViewBuilder.build(container: container)
        module.viewModel.didSendEventClosure = { [weak self] event in
            self?.showRecomendations()
        }
        
        navigationController.pushViewController(module.viewController, animated: true)
    }
    
    func showRecomendations() {
        let recomendationsCoordinator = RecomendationsCoordinator(navigationController, container: container)
        guard let userStateMetrics else { return }
        recomendationsCoordinator.recomendationType = .timerResetRecomendation(selectedReasons, userStateMetrics)
        recomendationsCoordinator.finishDelegate = finishDelegate
        childCoordinators.append(recomendationsCoordinator)
        recomendationsCoordinator.start()
    }
}
