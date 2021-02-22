//
//  APIServiceManager.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

class MockNetworkManager: NSObject, TeamNetworking, PlayerNetworking {
    
    var isFetchTeamCalled = false
    var isPlayerTeamCalled = false
    
    //TODO: Bring these methods to a repository class
    func getTeams(completion: @escaping ((Result<Teams, Error>)) -> Void) {
        
        self.isFetchTeamCalled = true
    }
    
    func getPlayers(page: Int, completion: @escaping ((Result<Players, Error>)) -> Void) {
        
        self.isPlayerTeamCalled = true
    }
}
