//
//  MoodClassifierCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.04.2023.
//

import UIKit
import SwiftUI

//protocol MoodClassifierCoordinatorProtocol: Coordinator {
//    func showMoodClassifierChoiceViewController()
//}
//
//final class MoodClassifierCoordinator: MoodClassifierCoordinatorProtocol {
//    internal func showMoodClassifierChoiceViewController() {
//        let viewModel = MoodClassifierSelectionViewModel()
//        let view = MoodClassifierSelectionView(viewModel: viewModel)
//        let vc = UIHostingController(rootView: view)
//        viewModel.didSendEventClosure = { [weak self] event in
//            switch event {
//            case .automatic:
//                self?.showCoreMLClassifierViewController()
//            case .manual:
//                self?.showManualClassifierViewController()
//            }
//        }
//        navigationController.pushWithCustomAnination(vc)
//    }
//    
//    private func showCoreMLClassifierViewController() {
//        let coordinator = CoreMLClassifierCoordinator(navigationController)
//        coordinator.finishDelegate = finishDelegate
//        coordinator.start()
//        childCoordinators.append(coordinator)
//    }
//    
//    private func showManualClassifierViewController() {
//        let coordinator = ManualMoodCoordinator(navigationController)
//        coordinator.finishDelegate = finishDelegate
//        coordinator.start()
//        childCoordinators.append(coordinator)
//    }
//    
//    weak var finishDelegate: CoordinatorFinishDelegate? 
//    
//    var navigationController: UINavigationController
//    
//    var childCoordinators: [Coordinator] = []
//    
//    var type: CoordinatorType {.moodClassifier}
//    
//    func start() {
//        navigationController.setNavigationBarHidden(false, animated: true)
//        showMoodClassifierChoiceViewController()
//    }
//    
//    init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    deinit {
//        print("\(self) deinited")
//    }
//}
