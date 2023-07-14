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
    func showLogin()
    func showMainFlow()
    func showReasonsToStop()
    //    func showRegistration()
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
    
    var type: CoordinatorType {.app}
    
    private var disposeBag = Set<AnyCancellable>()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLogin() {
        self.navigationController.setNavigationBarHidden(false, animated: false)
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
        print(navigationController.viewControllers)
    }
    // This should be called from push notification not tabbar
    func showMoodClassificationVC() {
        let moodClassifierCoordinator = MoodClassifierCoordinator(navigationController)
        moodClassifierCoordinator.finishDelegate = self
        moodClassifierCoordinator.start()
        childCoordinators.append(moodClassifierCoordinator)
    }
    
    func showRegistration() {
        let registrationCoordinator = FirstTimeEntryCoordinator(navigationController)
        registrationCoordinator.finishDelegate = self
        registrationCoordinator.start()
        childCoordinators.append(registrationCoordinator)
    }
    
    //    func showRecomendations() {
    //        UserDefaults.standard.set("Q6flCIpCmyfmifYHvyYcRGfkfPz1", forKey: "UserID")
    //        let storageService = FirebaseStorageService()
    //        let vm = RecomendationsViewModel(storageService: storageService)
    //        let vc = UIHostingController(rootView: RecomendationsView(viewModel: vm))
    //        navigationController.pushViewController(vc, animated: true)
    //    }
    
    
    // Fix starting main flow right after user registers
    func start() {
        
        FirebaseAuthStateHandler().checkIfUserIsAuthentificated { [weak self] result in
            switch result {
            case .userIsAuthentificated:
                self?.showMainFlow()
            case .userIsNotAuthentificated:
                self?.showLogin()
            }
        }
    }
    //        FirebaseAuthStateHandler().userState.sink { [weak self] result in
    //            switch result {
    //            case .userIsAuthentificated:
    //                self?.showMainFlow()
    //            case .userIsNotAuthentificated:
    //                self?.showLogin()
    //            }
    //        }.store(in: &disposeBag)
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func instantiateNewCoordinator(coordinator: CoordinatorType) {
        switch coordinator {
        case .reasonsToStop:
            showReasonsToStop()
        case .moodClassifier:
            showMoodClassificationVC()
        default:
            break
        }
    }
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        switch childCoordinator.type {
        case .tabbar:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            //            showLogin()
        case .auth:
            navigationController.viewControllers.removeAll()
            childCoordinators = []
            showMainFlow()
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
