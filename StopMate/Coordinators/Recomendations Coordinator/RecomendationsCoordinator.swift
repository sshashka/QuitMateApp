//
//  RecomendationsCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.06.2023.
//

import UIKit
import SwiftUI

protocol RecomendationsCoordinatorProtocol: Coordinator {
    func showRecomendationsView()
}

final class RecomendationsCoordinator: RecomendationsCoordinatorProtocol {
    var container: AppContainer
    
    init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    internal func showRecomendationsView() {
        let module = RecomentationsViewBuilder.build(container: container, typeOfRecomendation: recomendationType)
        module.viewModel.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(module.viewController, animated: true)
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var recomendationType: RecomendationsViewModel.TypeOfRecomendation = .moodRecomendation
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .recomendations }
    
    func start() {
        showRecomendationsView()
    }
}
