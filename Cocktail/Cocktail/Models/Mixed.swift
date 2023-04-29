//
//  Mixed.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/29/23.
//

import Foundation
import UIKit

struct Mixed: Identifiable, Codable {
    let id = UUID().uuidString
    var name: String
    var instructions: String
    var ingredients: [String]
    var imageData: Data?
    
    var uiImage: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name, instructions, imageData, ingredients
    }
}
