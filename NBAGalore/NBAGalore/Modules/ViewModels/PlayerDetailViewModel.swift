//
//  PlayerDetailViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import Foundation

class PlayerDetailViewModel: NSObject {
    
    //MARK: - Properties
    var coordinator: PlayerDetailCoordination!
    var choosenPlayer: Player!
    
    //MARK: - Navigation
    func dismissDetail() {
        
        self.coordinator.dismissPlayerDetail()
    }
}
