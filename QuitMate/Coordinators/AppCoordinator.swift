//
//  AppCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.04.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLogin()
    func showMainFlow()
    func showReasonsToStop()
}

final class AppCoordinator: AppCoordinatorProtocol {
    func showReasonsToStop() {
        let vc = ReasonsToStopCoordinator(navigationController)
        vc.finishDelegate = self
        vc.start()
        childCoordinators.append(vc)
    }
    
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.app}
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLogin() {
        let authCoordinator = LoginCoordinator(navigationController)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    func showMainFlow() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = TabBarCoordinator(navigationController)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
    
    func showMoodClassificationVC() {
        let moodClassifierCoordinator = MoodClassifierCoordinator(navigationController)
        moodClassifierCoordinator.finishDelegate = self
        moodClassifierCoordinator.start()
        childCoordinators.append(moodClassifierCoordinator)
    }
    
    func start() {
        //Add logics to determine if user is loggined
        showLogin()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        switch childCoordinator.type {
        case .tabbar:
            navigationController.viewControllers.removeAll()
            showReasonsToStop()
        case .login:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            showMainFlow()
        case .moodClassifier:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            showMainFlow()
        default:
            break
        }
    }
    
    
}
