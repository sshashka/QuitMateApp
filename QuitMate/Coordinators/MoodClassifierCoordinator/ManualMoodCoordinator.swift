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
    
    internal func showManualSelectionView() {
        let viewModel = ManualMoodClassifierModuleViewModel(storageService: FirebaseStorageService())
        let view = ManualMoodClassifierView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        viewModel.didSendEndEventClosure = { [weak self] event in
            self?.showRecomendations()
        }
        navigationController.pushWithCustomAnination(vc)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.moodClassifier}
    
    private func showRecomendations() {
        let coordinator = RecomendationsCoordinator(navigationController)
        coordinator.finishDelegate = finishDelegate
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func start() {
        showManualSelectionView()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) deinited")
    }
}
