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
    internal func showRecomendationsView() {
        let storageService = FirebaseStorageService()
        let viewModel = RecomendationsViewModel(storageService: storageService, type: recomendationType)
        let recomendationsVC = UIHostingController(rootView: RecomendationsView(viewModel: viewModel))
        viewModel.didSendEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(recomendationsVC, animated: true)
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var recomendationType: RecomendationsViewModel.TypeOfRecomendation = .moodRecomendation
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .recomendations }
    
    func start() {
        showRecomendationsView()
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) is deinited")
    }
}
