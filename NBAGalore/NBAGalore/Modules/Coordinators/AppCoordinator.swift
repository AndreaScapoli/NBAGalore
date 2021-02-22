//
//  AppCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

protocol AppCoordination {
    
    func coordinateToPlayerTable(withTeam team: String)
    func showError(withDesc desc: String)
}

class AppCoordinator: Coordinator, AppCoordination {
    
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
        presentTeamCollectionView()
    }
    
    // MARK: - Navigation
    private func presentTeamCollectionView() {
        
        let teamCollectionVC = UIStoryboard.instantiateTeamCollectionViewController()
        
        let viewModel = TeamCollectionViewModel()
        viewModel.coordinator = self
        teamCollectionVC.viewModel = viewModel
        
        
        navController.setViewControllers([teamCollectionVC], animated: true)
    }
    
    func coordinateToPlayerTable(withTeam team: String) {
        
        let playerCoordinator = PlayerCoordinator(navController: self.navController, window: self.window, data: team)
        playerCoordinator.start()
        
    }
    
    func showError(withDesc desc: String) {
        
        let alert = UIAlertController(title: "ERROR", message: desc, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.navController.popViewController(animated: true)
        }))
        
        DispatchQueue.main.async {
            self.navController.present(alert, animated: true, completion: nil)
        }
    }
}
