//
//  PlayerTableViewController.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

class PlayerTableViewController: UIViewController {
    
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var viewModel: PlayerTableViewModel!
    private var dataSource: TableDataSource<PlayerTableViewCell, Team>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.playerTableView.delegate = self
        
        self.setupLayout()
        self.updateTableDataSource(withData: [Team(id: 0, abbreviation: "we", city: "we", conference: "we", division: "we", full_name: "we", name: "we")])
    }
    
    private func setupLayout() {
        
        self.playerTableView.backgroundColor = .clear
        self.playerTableView.backgroundView?.backgroundColor = .clear
        
        self.backgroundImage.image = UIImage(named: "BasketBackground")
        self.backgroundImage.alpha = 0.6
        self.backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func updateTableDataSource(withData data: [Team]) {
        
        self.dataSource = TableDataSource(cellIdentifier: "playerCellId", items: data, configureCell: { (cell, data) in
            
            cell.playerName.text = "pippo"
        })
        
        DispatchQueue.main.async {
            
            self.playerTableView.dataSource = self.dataSource
            self.playerTableView.reloadData()
        }
    }
    
}

extension PlayerTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath)
    }
}
