//
//  TeamCollectionViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

class TeamCollectionViewModel: NSObject {
    
    var coordinator: AppCoordination?
    
    //MARK: Bindings
    private var teams: Teams? {
        didSet {
            self.teamsDidFetch?(self.teams)
        }
    }
    var teamsDidFetch: ((Teams?) -> Void)?
    
    override init() {
        super.init()
        
        self.retrieveData()
    }
    
    func retrieveData() {
        
        NetworkManager.shared.getTeams() { result in
            
            self.teams = result
        }
    }
    
    func navigateToPlayerTable() {
        
        self.coordinator?.coordinateToPlayerTable()
    }
}
