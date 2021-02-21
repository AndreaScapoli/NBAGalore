//
//  PlayerDetailCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import UIKit

protocol PlayerDetailCoordination {
    
    func dismissPlayerDetail()
}

class PlayerDetailCoordinator: Coordinator, PlayerDetailCoordination {
    
    //MARK: - Properties:
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
        presentPlayerDetailView()
    }
    
    private func presentPlayerDetailView() {
        
        let playerDetailVC = UIStoryboard.instantiatePlayerDetailViewController()
        
        let viewModel = PlayerDetailViewModel()
        viewModel.coordinator = self
        playerDetailVC.viewModel = viewModel
        
        navController.present(playerDetailVC, animated: true, completion: nil)
    }
    
    func dismissPlayerDetail() {
        
        self.navController.dismiss(animated: true, completion: nil)
    }
}
