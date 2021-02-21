//
//  PlayerDetailViewController.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //MARK: - Outlets:
    
    
    var viewModel: PlayerDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions:
    @IBAction func didTapButton(_ sender: Any) {
        
        self.viewModel.dismissDetail()
    }
    
}
