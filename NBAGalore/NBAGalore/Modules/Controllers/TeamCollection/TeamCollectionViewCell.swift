//
//  TeamCollectionViewCell.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    var teamId: Int?
    var teamAbr: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.backgroundColor = .lightGray
        self.contentView.alpha = 0.8
    }
    
    func configureCell(teamName: String, teamId: Int, teamAbr: String) {
        
        let label = UILabel(frame: CGRect(origin: self.bounds.origin, size: self.bounds.size))
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        
        self.addSubview(label)
        
        label.text = teamName
        self.teamId = teamId
        self.teamAbr = teamAbr
    }
    
}
