//
//  Player.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 21/02/21.
//

import Foundation

public struct Players: Codable {
    
    var data: [Player]?
    var meta: Metadata
}

public struct Player: Codable {
    
    var id: Int?
    var first_name: String?
    var height_feet: Int?
    var height_inches: Int?
    var last_name: String?
    var position: String?
    var team: Team?
    var weight_pounds: Int?
}

public struct Metadata: Codable {
    
    var total_pages: Int
    var current_page: Int
    var next_page: Int?
    var per_page: Int
    var total_count: Int
}
