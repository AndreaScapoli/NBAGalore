//
//  TeamCollectionViewModel.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewModel: NSObject {
    
    //MARK: - Properties
    var coordinator: AppCoordination?
    var networkManager: TeamNetworking?
    
    //MARK: Bindings
    private var dataSource: CollectionDataSource<TeamCollectionViewCell, TeamCollectionReusableView, Team>? {
        didSet {
            self.dataDidFetch?(self.dataSource)
        }
    }
    var dataDidFetch: ((UICollectionViewDataSource?) -> Void)?
    
    //MARK: - Methods
    func retrieveData() {
        
        networkManager?.getTeams() { [weak self] result in
            
            switch result {
            case .success(let teams):
                self?.updateCollectionDataSource(withData: teams.data)
            case .failure(let error):
                self?.coordinator?.showError(withDesc: error.localizedDescription)
            }
            
        }
    }
    
    private func updateCollectionDataSource(withData data: [Team]) {
        
        self.dataSource = CollectionDataSource(cellIdentifier: "teamCellId", items: data, headerViewIdentifier: "collectionHeader", headerTitle: "Choose A Team: ", configureCell: { (cell, headerView, data, headerTitle) in
            
            if let cell = cell {
                
                cell.configureCell(teamName: data?.full_name ?? "", teamId: data?.id ?? 0, teamAbr: data?.abbreviation ?? "")
            }
            
            if let headerView = headerView {
                
                headerView.headerTitle.text = headerTitle
            }
            
        })
    }
    
    //MARK: - Navigation
    func navigateToPlayerTable(withTeam team: String) {
        
        self.coordinator?.coordinateToPlayerTable(withTeam: team)
    }
}


