//
//  PlayerTableCoordinator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

protocol PlayerCoordination {
    
    func coordinateToPlayerDetail(withPlayer choosen: Player)
    func showError(withDesc desc: String)
}

class PlayerCoordinator: Coordinator, PlayerCoordination {
   
    // MARK: - Properties
    private let navController: UINavigationController
    private let window: UIWindow
    private let networkManager: NetworkManager
    private let data: String
    
    // MARK: - Initializer
    init(navController: UINavigationController, window: UIWindow, networkManager: NetworkManager, data: String) {
        self.navController = navController
        self.window = window
        self.data = data
        self.networkManager = networkManager
    }
    
    func start() {
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        presentPlayerTableView()
    }
    
    private func presentPlayerTableView() {
        
        let playerTableVC = UIStoryboard.instantiatePlayerTableViewController()
        let networkManager = NetworkManager()
        let viewModel = PlayerTableViewModel()
        
        viewModel.coordinator = self
        viewModel.networkManager = networkManager
        viewModel.choosenTeam = self.data
        playerTableVC.viewModel = viewModel
        
        navController.pushViewController(playerTableVC, animated: true)
    }
    
    func coordinateToPlayerDetail(withPlayer choosen: Player) {
        
        let playerDetailCoordinator = PlayerDetailCoordinator(navController: self.navController, window: self.window, choosenPlayer: choosen)
        playerDetailCoordinator.start()
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
