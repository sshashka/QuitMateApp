//
//  TabBarCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.04.2023.
//

import UIKit
import SwiftUI

protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }
}

final class TabBarCoordinator: NSObject, Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .tabbar }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPages] = [.charts, .home, .setup]
        
        let controllers: [UINavigationController] = pages.map {getTabControllers(page: $0)}
        
        setupTabBar(controllers: controllers)
        
    }
    
    private func showMoodClassifier(navVC: UINavigationController) {
        let moodCoordinator = MoodClassifierCoordinator(navVC)
        moodCoordinator.finishDelegate = finishDelegate
        childCoordinators.append(moodCoordinator)
        moodCoordinator.start()
//        self.finish()
    }
    
    private func showReasonsToStop() {
        let coordinator = ReasonsToStopCoordinator(navigationController)
        coordinator.finishDelegate = finishDelegate
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func getTabControllers(page: TabBarPages) -> UINavigationController {
        let navVC = UINavigationController()
        navVC.tabBarItem = UITabBarItem.init(title: nil, image: page.getImages(), selectedImage: nil)
        navVC.setNavigationBarHidden(false, animated: false)
        switch page {
        case .charts:
            let chartsVC = ProgressChartsModuleHostingViewController()
            navVC.pushViewController(chartsVC, animated: true)
        case .home:
            let vm = MainScreenViewModel()
            let mainView = MainScreenView(viewModel: vm)
            vm.didSendEventClosure = { [weak self] event in
                self?.showReasonsToStop()
            }
            let hostingVC = UIHostingController(rootView: mainView)
            navVC.pushViewController(hostingVC, animated: true)
        case .setup:
            let storageService = FirebaseStorageService()
            let vm = SettingsViewModel(storageService: storageService)
            let settingsVC = SettingsViewController(viewModel: vm)
            vm.didSendEventClosure = { [weak self] event in
                self?.showMoodClassifier(navVC: navVC)
            }
            navVC.pushViewController(settingsVC, animated: true)
            
        }
        return navVC
    }
    
    private func setupTabBar(controllers tabController: [UIViewController]) {
        tabBarController.tabBar.tintColor = UIColor(named: ColorConstants.buttonsColor)
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.setViewControllers(tabController, animated: true)
        navigationController.viewControllers = [tabBarController]
    }
}
