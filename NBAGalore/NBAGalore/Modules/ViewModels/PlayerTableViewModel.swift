//
//  PlayerTableViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import Foundation

class PlayerTableViewModel: NSObject {
    
    var coordinator: PlayerCoordination?
    
    func navigateToPlayerDetail() {
        
        self.coordinator?.coordinateToPlayerDetail()
    }
}
