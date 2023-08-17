//
//  Coordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.04.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? {get set}
    
    var navigationController: UINavigationController {get set}
    
    var childCoordinators: [Coordinator] {get set}
    
    var type: CoordinatorType {get}
    
    func start()
    
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll(keepingCapacity: false)
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func replaceWithNewCoordinator(coordinator: CoordinatorType) {
        finish()
        finishDelegate?.instantiateNewCoordinator(coordinator: coordinator)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
    func instantiateNewCoordinator(coordinator: CoordinatorType)
}

enum CoordinatorType {
    case app, auth, tabbar, moodClassifier, firstTimeEntry, reasonsToStop, register, recomendations, settings, onboarding
}
