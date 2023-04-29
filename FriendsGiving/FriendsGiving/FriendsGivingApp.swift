//
//  FriendsGivingApp.swift
//  FriendsGiving
//
//  Created by Thomas Stack on 4/18/23.
//

import SwiftUI

@main
struct FriendsGivingApp: App {
    @StateObject var friendsVM = FriendsViewModel()
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(friendsVM)
        }
    }
}
