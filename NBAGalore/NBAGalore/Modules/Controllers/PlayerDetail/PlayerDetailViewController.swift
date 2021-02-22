//
//  PlayerDetailViewController.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    //MARK: - Outlets:
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    
    @IBOutlet weak var inchesLabel: UILabel!
    @IBOutlet weak var inchesValue: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var positionValue: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamValue: UILabel!
    
    var viewModel: PlayerDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        guard let firstName = self.viewModel.choosenPlayer?.first_name else { return }
        guard let lastName = self.viewModel.choosenPlayer?.last_name else { return }
        self.playerNameLabel.text = firstName + " " + lastName
        
        self.heightLabel.text = "Height Feet: "
        if let height_feet = self.viewModel.choosenPlayer?.height_feet {
            self.heightValue.text = String(height_feet)
        }
        
        self.inchesLabel.text = "Height Inches: "
        if let height_inches = self.viewModel.choosenPlayer?.height_inches {
            self.inchesValue.text = String(height_inches)
        }
        
        self.positionLabel.text = "Position: "
        if let position = self.viewModel.choosenPlayer?.position {
            if position != "" {
                self.positionValue.text = String(position)
            }
        }
        
        self.weightLabel.text = "Weight Pounds: "
        if let weight_pounds = self.viewModel.choosenPlayer?.weight_pounds {
            self.weightValue.text = String(weight_pounds)
        }
        
        self.teamLabel.text = "Team: "
        if let teamValue = self.viewModel.choosenPlayer?.team?.full_name {
            self.teamValue.text = String(teamValue)
        }
        
    }
    
    //MARK: - Actions:
    @IBAction func didTapButton(_ sender: Any) {
        
        self.viewModel.dismissDetail()
    }
    
}
