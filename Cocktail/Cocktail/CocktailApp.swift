//
//  CocktailApp.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/22/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct CocktailApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var cocktailVM = ViewModel()
    @StateObject var mixVM = MixViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    
    init() {
        // set default font for all text views
        UILabel.appearance().font = UIFont(name: "Avenir Next", size: 17)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(cocktailVM)
                .environmentObject(mixVM)
                .environmentObject(favoritesVM)
        }
    }
    
}
