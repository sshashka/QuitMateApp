//
//  MoodClassifierCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.04.2023.
//

import UIKit
import SwiftUI

protocol MoodClassifierCoordinatorProtocol: Coordinator {
    func showMoodClassifierChoiceViewController()
    func showCoreMLClassifierViewController()
}

final class MoodClassifierCoordinator: MoodClassifierCoordinatorProtocol, CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        switch childCoordinator {
        default:
            self.finish()
        }
    }
    
    func showMoodClassifierChoiceViewController() {
        let viewModel = MoodClassifierSelectionViewModel()
        let view = MoodClassifierSelectionView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        viewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .automatic:
                self?.showCoreMLClassifierViewController()
            case .manual:
                self?.showManualClassifierViewController()
            }
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCoreMLClassifierViewController() {
        let coordinator = CoreMLClassifierCoordinator(navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func showManualClassifierViewController() {
        let coordinator = ManualMoodCoordinator(navigationController)
        coordinator.start()
        coordinator.finishDelegate = self
        childCoordinators.append(coordinator)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate? 
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.moodClassifier}
    
    func start() {
        showMoodClassifierChoiceViewController()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) deinited")
    }
}
