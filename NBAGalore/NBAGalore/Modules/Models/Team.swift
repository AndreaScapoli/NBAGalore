//
//  Team.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

struct Teams: Codable {
    
    var data: [Team]
}

struct Team: Codable {
    
    var id: Int
    var abbreviation: String
    var city: String
    var conference: String
    var division: String
    var full_name: String
    var name: String
}
