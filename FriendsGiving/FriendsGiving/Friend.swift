//
//  Friend.swift
//  FriendsGiving
//
//  Created by Thomas Stack on 4/18/23.
//

import Foundation

struct Friend: Identifiable, Codable {
    var id: String?
    var name = ""
    var bringing = ""
    var notes = ""
}
