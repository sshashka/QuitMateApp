//
//  ReasonsToStopCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.05.2023.
//

import UIKit

protocol ReasonsToStopCoordinatorProtocol: Coordinator {
    func showReasonsToStop()
}

final class ReasonsToStopCoordinator: ReasonsToStopCoordinatorProtocol {
    func showReasonsToStop() {
        let vc = ReasonsToStopViewController.module
        vc.presenter?.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
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
