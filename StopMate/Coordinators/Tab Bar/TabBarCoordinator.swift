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
    var container: AppContainer
    
    init(_ navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
        self.tabBarController = .init()
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .tabbar }

    
    func start() {
        let pages: [TabBarPages] = [.charts, .home, .videos]
        navigationController.setNavigationBarHidden(true, animated: true)
        
        let controllers: [UINavigationController] = pages.map {getTabControllers(page: $0)}
        
        setupTabBar(controllers: controllers)
    }
    
    
    private func showReasonsToStop() {
        self.replaceWithNewCoordinator(coordinator: .reasonsToStop)
    }
    
    private func getTabControllers(page: TabBarPages) -> UINavigationController {
        let navVC = UINavigationController()
        navVC.tabBarItem = UITabBarItem.init(title: nil, image: page.getImages(), selectedImage: nil)
        navVC.setNavigationBarHidden(false, animated: false)
        switch page {
        case .charts:
            let module = ChartsViewBuilder.build(container: container)
            module.viewModel.didSendEventClosure = { [weak self] event in
                switch event {
                case .newMood:
                    self?.finishDelegate?.instantiateNewCoordinator(coordinator: .moodClassifier)
                }
            }
            navVC.pushViewController(module.viewController, animated: true)
        case .home:
            container.firebaseStorageService.getUserModel()
            let module = MainScreenViewBuilder.build(container: container)
            module.viewModel.didSendEventClosure = { [weak self] event in
                switch event {
                case .didTapResetButton:
                    self?.showReasonsToStop()
                case .didTapOnSettings:
                    self?.showSettings(navigationVC: navVC)
                case .milestoneCompleted:
                    self?.showMilestoneCompletedView()
                }
            }
            let hostingVC = module.viewController
            navVC.pushWithCustomAnination(hostingVC)
        case .videos:
            let module = VideosViewBuilder.build(container: container)
            module.viewModel.didSendEvetClosure = { [weak self] event in
                switch event {
                case .didSelectVideo(let id):
                    self?.showVideoInfo(for: id, navigationVC: navVC)
                }
            }
            navVC.navigationBar.prefersLargeTitles = true
            navVC.pushViewController(module.viewController, animated: true)
        }
        return navVC
    }
    
    private func showMilestoneCompletedView() {
        let vm = MilestoneCompletedViewModel()
        let vc = UIHostingController(rootView: MilestoneCompletedView(vm: vm))
        
        vc.view.backgroundColor = UIColor(resource: .background)
        vm.didSendEvent = { [weak self] event in
            switch event {
            case .dontChangeAnything:
                vc.dismiss(animated: true)
            case .resetFinishingDate:
                vc.dismiss(animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.showReasonsToStop()
                }
            }
        }
        navigationController.present(vc, animated: true)
    }
    
    private func showVideoInfo(for id: String, navigationVC: UINavigationController) {
        let module = VideoInfoViewBuilder.build(container: container, id: id)
        module.viewModel.didSendEventClosure = { [weak self] event in
            switch event {
            case .loadVideo(let id):
                self?.showVideo(id: id, navigationVC: navigationVC)
            case .willAppear:
                navigationVC.navigationBar.prefersLargeTitles = false
            case .willDisappear:
                navigationVC.navigationBar.prefersLargeTitles = true
            }
        }
        let vc = module.viewController
        vc.title = nil
        navigationVC.pushViewController(vc, animated: true)
    }
    
    private func showVideo(id: String, navigationVC: UINavigationController) {
        let vc = YoutubePlayer()
        vc.videoID = id
        navigationVC.pushViewController(vc, animated: true)
    }
    
    private func showSettings(navigationVC: UINavigationController) {
        let coordinator = SettingsCoordinator(navigationVC, container: container)
        childCoordinators.append(coordinator)
        coordinator.finishDelegate = self.finishDelegate
        coordinator.start()
        coordinator.didSendEventClosure = { [weak self] child in
            self?.childCoordinators = self?.childCoordinators.filter({ $0.type != child.type }) ?? []
        }
    }
    
    private func setupTabBar(controllers tabController: [UIViewController]) {
        tabBarController.tabBar.tintColor = UIColor(named: ColorConstants.buttonsColor)
#if DEBUG
        tabBarController.tabBar.backgroundColor = UIColor(resource: .experimantalBackground)
#endif
        tabBarController.setViewControllers(tabController, animated: true)
        tabBarController.selectedIndex = 1
        navigationController.viewControllers = [tabBarController]
    }
}
