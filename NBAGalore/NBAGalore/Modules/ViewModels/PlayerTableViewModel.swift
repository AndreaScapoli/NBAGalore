//
//  PlayerTableViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

class PlayerTableViewModel: NSObject {
    
    //MARK: - Properties
    var coordinator: PlayerCoordination?
    var networkManager: PlayerNetworking?
    
    var choosenTeam: String?
    var playerList = [Player]()
    
    var numberOfFetch: Int = 20
    var nextPage: Int? = 1
    var isPaginating: Bool = false
    
    //MARK: - Bindings
    private var dataSource: TableDataSource<PlayerTableViewCell, Player>? {
        didSet {
            self.dataDidFetch?(self.dataSource)
        }
    }
    var dataDidFetch: ((UITableViewDataSource?) -> Void)?
    
    private var loadFinsihed: Bool? {
        didSet {
            self.didFinishLoad?(self.loadFinsihed)
        }
    }
    var didFinishLoad: ((Bool?) -> Void)?
    
    //MARK: - Method
    func retrieveData() {
        
        //If is the last page do not fetch more data
        guard nextPage != nil else { return self.loadFinsihed = true }
        
        networkManager?.getPlayers(page: nextPage ?? 1) { [weak self] result in
            
            switch result{
            case .success(let players):
                self?.filterDataFromTeam(data: players)
            case .failure(let error):
                self?.loadFinsihed = true
                self?.coordinator?.showError(withDesc: error.localizedDescription)
            }
            
        }
    }
    
    private func filterDataFromTeam(data: Players) {
        
        self.nextPage = data.meta.next_page
        
        for player in data.data! {
            
            if player.team?.abbreviation == self.choosenTeam {
                
                self.playerList.append(player)
            }
        }
        
        if playerList.count >= self.numberOfFetch {
            
            self.isPaginating = false
            self.updateTableDataSource(withData: playerList)
        } else {
            
            self.retrieveData()
        }
    }
    
    private func updateTableDataSource(withData data: [Player]) {
        
        self.dataSource = TableDataSource(cellIdentifier: "playerCellId", items: data, configureCell: { (cell, data) in
            
            guard let firstName = data.first_name else { return }
            guard let lastName = data.last_name else { return }
            cell.playerName.text = firstName + " " + lastName
        })
        
    }
    
    //MARK: - Navigation
    func navigateToPlayerDetail(indexPath: IndexPath) {
        
        self.coordinator?.coordinateToPlayerDetail(withPlayer: playerList[indexPath.row])
    }
}
