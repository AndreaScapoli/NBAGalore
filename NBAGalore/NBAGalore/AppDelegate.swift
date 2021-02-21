//
//  AppDelegate.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var app: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController()
        navController.navigationBar.barTintColor = .black
        
        let appCoordinator = AppCoordinator(navController: navController, window: window)
        app = appCoordinator
      
        appCoordinator.start()
        
        return true
        
    }

}

