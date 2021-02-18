//
//  TeamCollectionViewCell.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets:
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func configureCell(name: String) {
        
        self.teamName.text = name
    }
    
}
