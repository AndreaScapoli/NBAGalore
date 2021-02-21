//
//  TeamCollectionViewCell.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets:
    
    @IBOutlet weak var teamName: UILabel!
    
    var teamId: Int?
    var teamAbr: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.backgroundColor = .lightGray
        self.contentView.alpha = 0.8
        
        teamName.numberOfLines = 0
    }
    
    func configureCell(teamName: String, teamId: Int, teamAbr: String) {
        
        self.teamName.text = teamName
        self.teamId = teamId
        self.teamAbr = teamAbr
    }
    
}
