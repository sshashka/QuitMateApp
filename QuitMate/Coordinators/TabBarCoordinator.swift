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
    private lazy var storageService: FirebaseStorageServiceProtocol = {
        return FirebaseStorageService()
    }()
    
    private lazy var authService: AuthentificationServiceProtocol = {
        return FirebaseAuthentificationService()
    }()
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .tabbar }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    deinit {
        print("\(self) is deinited")
    }
    
    func start() {
        let pages: [TabBarPages] = [.charts, .home, .videos]
        navigationController.setNavigationBarHidden(true, animated: true)
        
        let controllers: [UINavigationController] = pages.map {getTabControllers(page: $0)}
        
        setupTabBar(controllers: controllers)
    }
    
//    private func showMoodClassifier(navVC: UINavigationController) {
//        let moodCoordinator = MoodClassifierCoordinator(navVC)
//        moodCoordinator.finishDelegate = finishDelegate
//        childCoordinators.append(moodCoordinator)
//        moodCoordinator.start()
//        self.finish()
//    }
    
    private func showReasonsToStop() {
        self.replaceWithNewCoordinator(coordinator: .reasonsToStop)
//        let coordinator = ReasonsToStopCoordinator(navigationController)
//        coordinator.finishDelegate = finishDelegate
//        self.replaceWithNewCoordinator(coordinator: coordinator)
//        coordinator.start()
    }
    
    private func getTabControllers(page: TabBarPages) -> UINavigationController {
        let navVC = UINavigationController()
        navVC.tabBarItem = UITabBarItem.init(title: nil, image: page.getImages(), selectedImage: nil)
        navVC.setNavigationBarHidden(false, animated: false)
        switch page {
        case .charts:
            let chartsVM = ProgressChartsViewModel(storageService: storageService)
//            let chartsVC = ProgressChartsModuleHostingViewController()
            let vc = UIHostingController(rootView: ProgressChartsModuleMainScreen(viewModel: chartsVM))
            navVC.pushViewController(vc, animated: true)
        case .home:
            let vm = MainScreenViewModel(storageService: FirebaseStorageService())
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
//            videosVC.title = "Videos"
//            navVC.navigationBar.prefersLargeTitles = true
            viewModel.didSendEvetClosure = { [weak self] event in
                switch event {
                case .didSelectVideo(let id):
                    self?.showVideoInfo(for: id, navigationVC: navVC)
                }
            }
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
            }
        }
        let vc = UIHostingController(rootView: VideoInfoView(vm: vm))
        vc.title = nil
        navigationVC.navigationBar.prefersLargeTitles = false
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
    }
    
    private func setupTabBar(controllers tabController: [UIViewController]) {
        tabBarController.tabBar.tintColor = UIColor(named: ColorConstants.buttonsColor)
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.setViewControllers(tabController, animated: true)
        tabBarController.selectedIndex = 1
        navigationController.viewControllers = [tabBarController]
    }
}
