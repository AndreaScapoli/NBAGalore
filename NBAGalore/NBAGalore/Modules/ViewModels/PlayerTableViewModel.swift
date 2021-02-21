//
//  PlayerTableViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import Foundation

class PlayerTableViewModel: NSObject {
    
    //MARK: - Properties
    var coordinator: PlayerCoordination?
    var choosenTeam: String?
    var playerList = [Player]()
    
    private var nextPage: Int? = 1
    
    //MARK: - Bindings
    private var finishedLoading: Bool = false {
        didSet {
            self.loadingDidFinish?(self.finishedLoading)
        }
    }
    var loadingDidFinish: ((Bool?) -> Void)?
    
    //MARK: - Method
    func retrieveData() {
        
        NetworkManager.shared.getPlayers(page: nextPage ?? 1) { (result) in
            
            switch result{
            case .success(let players):
                self.filterDataFromTeam(data: players)
            case .failure(let error):
                self.finishedLoading = true
                self.coordinator?.showError(withDesc: error.localizedDescription)
            }
            
        }
    }
    
    private func filterDataFromTeam(data: Players) {
        
        self.nextPage = data.meta.next_page
        
        guard nextPage != nil else { return self.finishedLoading = true }
        
        for player in data.data! {
            
            if player.team?.abbreviation == self.choosenTeam {
                
                self.playerList.append(player)
            }
        }
        
        self.retrieveData()
    }
    
    //MARK: - Navigation
    func navigateToPlayerDetail(indexPath: IndexPath) {
        
        self.coordinator?.coordinateToPlayerDetail(withPlayer: playerList[indexPath.row])
    }
}
