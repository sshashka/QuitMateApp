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
        let vc = ReasonsToStopCoordinator(navigationController, container: container)
        vc.finishDelegate = self
        vc.start()
        childCoordinators.append(vc)
    }
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var container: AppContainer
    
//    private let firebaseStorageService = FirebaseStorageService()
//    
//    private let firebaseAuthStateHandler = FirebaseAuthStateHandler()
    
    var type: CoordinatorType {.app}
    
    private var disposeBag = Set<AnyCancellable>()
    
    required init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    private func showLogin() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        self.navigationController.setNavigationBarHidden(false, animated: false)
        let authCoordinator = LoginCoordinator(navigationController, container: container)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    private func showMainFlow() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        navigationController.setNavigationBarHidden(true, animated: false)
        let mainCoordinator = TabBarCoordinator(navigationController, container: container)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }

    private func showMoodClassificationVC() {
        let moodClassifierCoordinator = ManualMoodCoordinator(navigationController, container: container)
        moodClassifierCoordinator.finishDelegate = self
        moodClassifierCoordinator.start()
        childCoordinators.append(moodClassifierCoordinator)
    }
    
    private func showFirstTimeEntryFlow() {
        childCoordinators = []
        navigationController.viewControllers.removeAll()
        let coordinator = FirstTimeEntryCoordinator(navigationController, container: container)
        coordinator.finishDelegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showRegistration() {
        let registrationCoordinator = FirstTimeEntryCoordinator(navigationController, container: container)
        registrationCoordinator.finishDelegate = self
        registrationCoordinator.start()
        childCoordinators.append(registrationCoordinator)
    }
    
    private func showOnboarding() {
        navigationController.viewControllers = []
        childCoordinators = []
        let onboardingCoordinator = OnboardingCoordinator(navigationController, container: container)
        onboardingCoordinator.finishDelegate = self
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    func start() {
        ApiKeysService.shared.setKeys()
        UINavigationBar.appearance().tintColor = UIColor(named: ColorConstants.buttonsColor)
        let loaderVC = UIHostingController(rootView: LoaderView())
        navigationController.pushWithCustomAnination(loaderVC)
        container.firebaseAuthStateHandler.checkIfUserIsAuthentificated()
            .debounce(for: 2, scheduler: RunLoop.main)
            .sink {[weak self] result in
            self?.navigationController.popWithCustomAnimation(loaderVC)
            switch result {
            case .userIsAuthentificated:
                self?.showMainFlow()
            case .userIsNotAuthentificated:
                self?.showLogin()
            case .userNeedsToCompleteRegistration:
                self?.showFirstTimeEntryFlow()
            case .userDidNotCompleteOnboarding:
                self?.showOnboarding()
            }
        }.store(in: &disposeBag)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func instantiateNewCoordinator(coordinator: CoordinatorType) {
        switch coordinator {
        case .reasonsToStop:
            navigationController.viewControllers = []
            childCoordinators = []
            showReasonsToStop()
        case .moodClassifier:
            navigationController.viewControllers.removeAll()
            childCoordinators.removeAll()
            showMoodClassificationVC()
        case .firstTimeEntry:
            navigationController.viewControllers.removeAll()
            childCoordinators.removeAll()
            showFirstTimeEntryFlow()
        case .onboarding:
            navigationController.viewControllers = []
            childCoordinators = []
            showOnboarding()
        case .tabbar:
            navigationController.viewControllers = []
            childCoordinators = []
            showMainFlow()
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
        case .firstTimeEntry:
            navigationController.viewControllers = []
            childCoordinators = []
            showOnboarding()
        case .onboarding:
            navigationController.viewControllers = []
            childCoordinators = []
            showMainFlow()
        default:
            break
        }
    }
}
