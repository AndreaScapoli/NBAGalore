//
//  ViewController.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    private let viewModel = TeamCollectionViewModel()
    private var dataSource: CollectionDataSource<TeamCollectionViewCell, Team>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupBindings()
    }
    
    private func setupBindings() {
        
        self.viewModel.teamsDidFetch = { [weak self] teams in
            
            self?.updateCollectionDataSource(withData: teams?.data ?? [])
        }
    }
    
    private func setupLayout() {
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.backgroundView?.backgroundColor = .clear
        
        self.backgroundImage.image = UIImage(named: "BasketBackground")
        self.backgroundImage.alpha = 0.6
    }
    
    private func updateCollectionDataSource(withData data: [Team]) {
        
        self.dataSource = CollectionDataSource(cellIdentifier: "TeamCellId", items: data, configureCell: { (cell, data) in
            
            cell.configureCell(teamName: data.full_name, teamId: data.id)
        })
        
        DispatchQueue.main.async {
            
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
}
