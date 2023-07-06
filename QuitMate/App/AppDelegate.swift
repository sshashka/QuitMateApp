//
//  AppDelegate.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.02.2023.
//

import UIKit
import FirebaseCore
//import Combine
//import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow()
        
        let navVC = UINavigationController()
        window?.rootViewController = navVC
        
        appCoordinator = AppCoordinator(navVC)
        appCoordinator?.start()
//        FirebaseAuthStateHandler().userState.sink {[weak self] result in
//            self?.appCoordinator?.startStategy = result
//            self?.appCoordinator?.start()
//        }.store(in: &disposeBag)
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
//        UserDefaults.standard.set(nil, forKey: "UserID")
    }
}

