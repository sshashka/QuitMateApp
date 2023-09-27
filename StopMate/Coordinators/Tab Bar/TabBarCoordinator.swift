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
    private var storageService = FirebaseStorageService()
    private var authService = FirebaseAuthentificationService()
    
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
//        navVC.delegate = se
        navVC.tabBarItem = UITabBarItem.init(title: nil, image: page.getImages(), selectedImage: nil)
        navVC.setNavigationBarHidden(false, animated: false)
        switch page {
        case .charts:
            let chartsVM = ProgressChartsViewModel(storageService: storageService)
            chartsVM.didSendEventClosure = { [weak self] event in
                switch event {
                case .newMood:
                    self?.finishDelegate?.instantiateNewCoordinator(coordinator: .moodClassifier)
                }
            }
            let vc = UIHostingController(rootView: ProgressChartsView(viewModel: chartsVM))
            navVC.pushViewController(vc, animated: true)
        case .home:
            storageService.getUserModel()
            let vm = MainScreenViewModel(storageService: storageService)
            let mainView = MainScreenView(viewModel: vm)
            vm.didSendEventClosure = { [weak self] event in
                switch event {
                case .didTapResetButton:
                    self?.showReasonsToStop()
                case .didTapOnSettings:
                    self?.showSettings(navigationVC: navVC)
                }
            }
            let hostingVC = UIHostingController(rootView: mainView)
            navVC.pushWithCustomAnination(hostingVC)
        case .videos:
            let youtubeService = YoutubeApiService()
            let viewModel = VideoSelectionViewModel(youtubeService: youtubeService)
            let videosVC = UIHostingController(rootView: VideoSelectionView(viewModel: viewModel))
            viewModel.didSendEvetClosure = { [weak self] event in
                switch event {
                case .didSelectVideo(let id):
                    self?.showVideoInfo(for: id, navigationVC: navVC)
                }
            }
            navVC.navigationBar.prefersLargeTitles = true
            navVC.pushViewController(videosVC, animated: true)
        }
        return navVC
    }
    
    private func showVideoInfo(for id: String, navigationVC: UINavigationController) {
        let vm = VideoInfoViewModel(youtubeService: YoutubeApiService(), id: id)
        vm.didSendEventClosure = { [weak self] event in
            switch event {
            case .loadVideo(let id):
                self?.showVideo(id: id, navigationVC: navigationVC)
            case .willAppear:
                navigationVC.navigationBar.prefersLargeTitles = false
            case .willDisappear:
                navigationVC.navigationBar.prefersLargeTitles = true
            }
        }
        let vc = UIHostingController(rootView: VideoInfoView(vm: vm))
        vc.title = nil
        navigationVC.pushViewController(vc, animated: true)
    }

    private func showVideo(id: String, navigationVC: UINavigationController) {
        let vc = YoutubePlayer()
        vc.videoID = id
        navigationVC.pushViewController(vc, animated: true)
    }

    private func showSettings(navigationVC: UINavigationController) {
        let coordinator = SettingsCoordinator(navigationVC)
        childCoordinators.append(coordinator)
        coordinator.finishDelegate = self.finishDelegate
        coordinator.start()
        coordinator.didSendEventClosure = { [weak self] child in
            self?.childCoordinators = self?.childCoordinators.filter({ $0.type != child.type }) ?? []
        }
    }

    private func setupTabBar(controllers tabController: [UIViewController]) {
        tabBarController.tabBar.tintColor = UIColor(named: ColorConstants.buttonsColor)
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.setViewControllers(tabController, animated: true)
        tabBarController.selectedIndex = 1
        navigationController.viewControllers = [tabBarController]
    }
}
