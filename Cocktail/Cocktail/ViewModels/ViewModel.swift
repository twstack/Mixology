//
//  ViewModel.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/22/23.
//

import Foundation
import Firebase

@MainActor
class ViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var drinks: [Cocktail]
    }
    
    @Published var urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    @Published var cocktailArray: [Cocktail] = []
    @Published var mixedDrinks: [Cocktail] = []

    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data)
                cocktailArray = returned.drinks
            } catch {
                print("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
            }
        } catch {
            print("ERROR: Could not get data from urlString \(urlString)")
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            print("Log out successful!")
        } catch {
            print("ERROR: Could not sign out!")
        }
    }
}
