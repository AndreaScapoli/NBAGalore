//
//  PlayerTableCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

protocol PlayerCoordination {
    
    func coordinateToPlayerDetail()
}

class PlayerCoordinator: Coordinator, PlayerCoordination {
   
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
        
        let viewModel = PlayerTableViewModel()
        viewModel.coordinator = self
        playerTableVC.viewModel = viewModel
        
        navController.pushViewController(playerTableVC, animated: true)
    }
    
    func coordinateToPlayerDetail() {
        
        let playerDetailCoordinator = PlayerDetailCoordinator(navController: self.navController, window: self.window)
        playerDetailCoordinator.start()
    }
}
