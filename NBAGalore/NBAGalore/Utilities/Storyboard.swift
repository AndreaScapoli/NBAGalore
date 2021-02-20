//
//  StoryboardInstantiator.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - Storyboards
    private static var teamCollectionStoryboard: UIStoryboard {
      return UIStoryboard(name: "TeamCollection", bundle: nil)
        
    }
    
    // MARK: - View Controllers
    static func instantiateTeamCollectionViewController() -> TeamCollectionViewController {
      let teamCollectionVC = teamCollectionStoryboard.instantiateViewController(withIdentifier: "teamCollection") as! TeamCollectionViewController
      
      return teamCollectionVC
        
    }
}
