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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: PlayerTableViewModel!
    private var dataSource: TableDataSource<PlayerTableViewCell, Player>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.playerTableView.delegate = self
        
        self.setupLayout()
        self.setupBindings()

        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.viewModel.retrieveData()
    }
    
    private func setupLayout() {
        
        self.playerTableView.backgroundColor = .clear
        self.playerTableView.backgroundView?.backgroundColor = .clear
        
        self.backgroundImage.image = UIImage(named: "BasketBackground")
        self.backgroundImage.alpha = 0.6
        self.backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setupBindings() {
        
        self.viewModel.loadingDidFinish = { [weak self] loaded in
            
            DispatchQueue.main.async {
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
            
            if loaded ?? false {
                
                DispatchQueue.main.async {
                    self?.playerTableView.tableFooterView = nil
                }
                self?.updateTableDataSource(withData: self?.viewModel.playerList ?? [])
            }
            
        }
    }
    
    private func updateTableDataSource(withData data: [Player]) {
        
        self.dataSource = TableDataSource(cellIdentifier: "playerCellId", items: data, configureCell: { (cell, data) in
            
            guard let firstName = data.first_name else { return }
            guard let lastName = data.last_name else { return }
            cell.playerName.text = firstName + " " + lastName
        })
        
        DispatchQueue.main.async {
            
            self.playerTableView.dataSource = self.dataSource
            self.playerTableView.reloadData()
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = footerView.center
        spinner.startAnimating()
        spinner.color = .black
        
        footerView.addSubview(spinner)
        
        return footerView
    }
    
}

extension PlayerTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.navigateToPlayerDetail(indexPath: indexPath)
    }
}

extension PlayerTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > (self.playerTableView.contentSize.height - 100 - scrollView.frame.size.height) && !self.viewModel.isPaginating {
            
            self.playerTableView.tableFooterView = createSpinnerFooter()
            
            self.viewModel.numberOfFetch += 20
            self.viewModel.isPaginating = true
            self.viewModel.retrieveData()
        }
        
    }
}
