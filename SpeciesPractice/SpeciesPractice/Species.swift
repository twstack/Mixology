//
//  Species.swift
//  SpeciesPractice
//
//  Created by Thomas Stack on 4/28/23.
//

import Foundation

struct Species: Identifiable, Codable {
    let id = UUID().uuidString
    var name = ""
    var classification = ""
    var designation = ""
    var average_height = ""
    var average_lifespan = ""
    var language = ""
    var skin_colors = ""
    var hair_colors = ""
    var eye_colors = ""
    
    enum CodingKeys: CodingKey {
        case name, classification, designation, average_height, average_lifespan, language, skin_colors, hair_colors, eye_colors
    }
}
