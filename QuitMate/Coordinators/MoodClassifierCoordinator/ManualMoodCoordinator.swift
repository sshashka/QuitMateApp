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
    func showManualSelectionView() {
        let viewModel = ManualMoodClassifierModuleViewModel()
        let view = MoodClassifierMainScreenView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        viewModel.didSendEndEventClosure = { [weak self] event in
            self?.finish()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType {.moodClassifier}
    
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
