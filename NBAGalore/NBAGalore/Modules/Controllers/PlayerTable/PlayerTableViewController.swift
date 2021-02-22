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
        
        self.viewModel.dataDidFetch = { [weak self] data in
            
            DispatchQueue.main.async {
                
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
                self?.playerTableView.tableFooterView = nil
                self?.playerTableView.dataSource = data
                self?.playerTableView.reloadData()
            }
        }
        
        self.viewModel.didFinishLoad = { [weak self] finish in
            
            if finish ?? false {
                
                DispatchQueue.main.async {
                    self?.playerTableView.tableFooterView = nil
                }
            }
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
            
            self.viewModel.numberOfFetch += 10
            self.viewModel.isPaginating = true
            self.viewModel.retrieveData()
        }
        
    }
}
