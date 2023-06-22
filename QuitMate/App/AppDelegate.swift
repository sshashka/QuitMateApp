//
//  AppDelegate.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.02.2023.
//

import UIKit
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let navVC = UINavigationController()
        window?.rootViewController = navVC
        
        appCoordinator = AppCoordinator(navVC)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(nil, forKey: "UserID")
    }
}

