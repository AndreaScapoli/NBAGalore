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
        
        guard let height_feet = self.viewModel.choosenPlayer?.height_feet else { return }
        self.heightValue.text = String(height_feet)
        self.inchesLabel.text = "Height Inches: "
        guard let height_inches = self.viewModel.choosenPlayer?.height_inches else { return }
        self.inchesValue.text = String(height_inches)
        self.positionLabel.text = "Position: "
        guard let position = self.viewModel.choosenPlayer?.position else { return }
        self.positionValue.text = String(position)
        self.weightLabel.text = "Weight Pounds: "
        guard let weight_pounds = self.viewModel.choosenPlayer?.weight_pounds else { return }
        self.weightValue.text = String(weight_pounds)
        
    }
    
    //MARK: - Actions:
    @IBAction func didTapButton(_ sender: Any) {
        
        self.viewModel.dismissDetail()
    }
    
}
