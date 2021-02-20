//
//  AppCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navController: UINavigationController
    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []
    
    // MARK: - Initializer
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    func start() {
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        presentTeamCollectionView()
    }
    
    // MARK: - Navigation
    private func presentTeamCollectionView() {
        
      let teamCollectionVC = UIStoryboard.instantiateTeamCollectionViewController()
      navController.setViewControllers([teamCollectionVC], animated: true)
//      childCoordinators.removeAll { $0 is AuthCoordinator }
    }
}
