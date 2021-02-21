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
    
    var viewModel: TeamCollectionViewModel!
    private var dataSource: CollectionDataSource<TeamCollectionViewCell, TeamCollectionReusableView, Team>!
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        self.setupLayout()
        self.setupBindings()
        
        self.viewModel.retrieveData()
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
        self.backgroundImage.contentMode = .scaleAspectFill
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
        
        DispatchQueue.main.async {
            
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
}

extension TeamCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TeamCollectionViewCell
        
        self.viewModel.navigateToPlayerTable(withTeam: cell.teamAbr ?? "")
    }
}

extension TeamCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
}
