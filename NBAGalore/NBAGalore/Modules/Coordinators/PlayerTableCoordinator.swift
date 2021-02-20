//
//  PlayerTableCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

class PlayerCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navController: UINavigationController
    private let window: UIWindow
    
    // MARK: - Initializer
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    func start() {
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        presentPlayerTableView()
    }
    
    private func presentPlayerTableView() {
        
        let playerTableVC = UIStoryboard.instantiatePlayerTableViewController()
        
        playerTableVC.viewModel = PlayerTableViewModel()
        
        navController.pushViewController(playerTableVC, animated: true)
//        navController.present(playerTableVC, animated: true, completion: nil)
    }
    
    
}
