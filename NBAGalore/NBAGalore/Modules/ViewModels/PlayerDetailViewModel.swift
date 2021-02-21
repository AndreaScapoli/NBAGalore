//
//  PlayerDetailViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import Foundation

class PlayerDetailViewModel: NSObject {
    
    var coordinator: PlayerDetailCoordination!
    var choosenPlayer: Player?
    
    func dismissDetail() {
        
        self.coordinator.dismissPlayerDetail()
    }
}
