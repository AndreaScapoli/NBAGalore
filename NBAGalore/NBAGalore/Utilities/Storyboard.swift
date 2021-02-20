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
    
    private static var playerTableStoryboard: UIStoryboard {
        return UIStoryboard(name: "PlayerTable", bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateTeamCollectionViewController() -> TeamCollectionViewController {
      let teamCollectionVC = teamCollectionStoryboard.instantiateViewController(withIdentifier: "teamCollection") as! TeamCollectionViewController
      
      return teamCollectionVC
        
    }
    
    static func instantiatePlayerTableViewController() -> PlayerTableViewController {
        let playerTableVC = playerTableStoryboard.instantiateViewController(withIdentifier: "playerTable") as! PlayerTableViewController
        
        return playerTableVC
    }
    

}
