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
            let hostingVC = UIHostingController(rootView: mainView)
            navVC.pushViewController(hostingVC, animated: true)
        case .setup:
            let settingsVC = SettingsViewController()
            navVC.pushViewController(settingsVC, animated: true)
            
        }
        return navVC
    }
    
    private func setupTabBar(controllers tabController: [UIViewController]) {
        tabBarController.tabBar.tintColor = UIColor(named: ColorConstants.purpleColor)
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.setViewControllers(tabController, animated: true)
        navigationController.viewControllers = [tabBarController]
    }
}
