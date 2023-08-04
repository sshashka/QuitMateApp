//
//  AppCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.04.2023.
//

import UIKit
import SwiftUI
import Combine

protocol AppCoordinatorProtocol: Coordinator {
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    func showReasonsToStop() {
        let vc = ReasonsToStopCoordinator(navigationController)
        vc.finishDelegate = self
        vc.start()
        childCoordinators.append(vc)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController {
        didSet {
            print(navigationController.viewControllers)
        }
    }
    
    var childCoordinators: [Coordinator] = [] {
        didSet {
            print(childCoordinators)
        }
    }
    
    private let firebaseStorageService = FirebaseStorageService()
    
    private var firebaseAuthStateHandler = FirebaseAuthStateHandler()
    
    var type: CoordinatorType {.app}
    
    private var disposeBag = Set<AnyCancellable>()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func showLogin() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        self.navigationController.setNavigationBarHidden(false, animated: false)
        let authCoordinator = LoginCoordinator(navigationController)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    private func showMainFlow() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        navigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = TabBarCoordinator(navigationController)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
        print(navigationController.viewControllers)
    }
    // This should be called from push notification not tabbar
    private func showMoodClassificationVC() {
        //        let moodClassifierCoordinator = MoodClassifierCoordinator(navigationController)
        let moodClassifierCoordinator = ManualMoodCoordinator(navigationController)
        moodClassifierCoordinator.finishDelegate = self
        moodClassifierCoordinator.start()
        childCoordinators.append(moodClassifierCoordinator)
    }
    
    private func showFirstTimeEntryFlow() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        let coordinator = FirstTimeEntryCoordinator(navigationController)
        //        finishDelegate?.replaceWithNewCoordinator(coordinator: coordinator)
        coordinator.finishDelegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showRegistration() {
        let registrationCoordinator = FirstTimeEntryCoordinator(navigationController)
        registrationCoordinator.finishDelegate = self
        registrationCoordinator.start()
        childCoordinators.append(registrationCoordinator)
    }
    
    func start() {
        UINavigationBar.appearance().tintColor = UIColor(named: ColorConstants.buttonsColor)
        let loaderVC = UIHostingController(rootView: LoaderView())
        navigationController.pushWithCustomAnination(loaderVC)
        firebaseAuthStateHandler.checkIfUserIsAuthentificated().sink {[weak self] result in
            self?.navigationController.popWithCustomAnimation(loaderVC)
            switch result {
            case .userIsAuthentificated:
                self?.showMainFlow()
            case .userIsNotAuthentificated:
                self?.showLogin()
            case .userNeedsToCompleteRegistration:
                self?.showFirstTimeEntryFlow()
            }
        }.store(in: &disposeBag)
    }
    
    //    private func showLoaderView(completion: @escaping() -> Void) {
    //        let loaderVC = UIHostingController(rootView: LoaderView())
    //        navigationController.pushWithCustomAnination(loaderVC)
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    //            self.navigationController.popWithCustomAnimation(loaderVC)
    //            completion()
    //        }
    //    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func instantiateNewCoordinator(coordinator: CoordinatorType) {
        switch coordinator {
        case .reasonsToStop:
            showReasonsToStop()
        case .moodClassifier:
            navigationController.viewControllers.removeAll()
            childCoordinators.removeAll()
            showMoodClassificationVC()
        case .firstTimeEntry:
            navigationController.viewControllers.removeAll()
            childCoordinators.removeAll()
            showFirstTimeEntryFlow()
        default:
            fatalError("\(coordinator) instantiateNewCoordinator is not implemented")
        }
    }
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        switch childCoordinator.type {
        case .tabbar:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
        case .auth:
            childCoordinators = []
        case .moodClassifier:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            showMainFlow()
        case .register:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            showMainFlow()
        case .recomendations:
            navigationController.viewControllers = []
            childCoordinators = []
            showMainFlow()
        case .reasonsToStop:
            navigationController.viewControllers = []
            childCoordinators = []
            showMainFlow()
        default:
            break
        }
    }
}