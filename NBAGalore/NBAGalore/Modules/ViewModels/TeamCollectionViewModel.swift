//
//  TeamCollectionViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

class TeamCollectionViewModel: NSObject {
    
    //MARK: - Properties
    var coordinator: AppCoordination?
    var networkManager: TeamNetworking?
    
    //MARK: Bindings
    private var teams: Teams? {
        didSet {
            self.teamsDidFetch?(self.teams)
        }
    }
    var teamsDidFetch: ((Teams?) -> Void)?
    
    //MARK: - Methods
    func retrieveData() {
        
        networkManager?.getTeams() { [weak self] result in
            
            switch result {
            case .success(let teams):
                self?.teams = teams
            case .failure(let error):
                self?.coordinator?.showError(withDesc: error.localizedDescription)
            }
            
        }
    }
    
    //MARK: - Navigation
    func navigateToPlayerTable(withTeam team: String) {
        
        self.coordinator?.coordinateToPlayerTable(withTeam: team)
    }
}


