//
//  FavoriteView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/28/23.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    NavigationStack {
                        VStack {
                            Image("CocktailsTitle")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.9)
                                .padding()
                                .foregroundColor(Color("MixologyDark"))
                                .shadow(color: .white, radius: 2.5)
                                .brightness(0.05)
                        }
                        .background(Color("MixologyDark"))
                        
                        List(favoritesVM.favoritedCocktails) { cocktail in
                            NavigationLink {
                                DetailView(cocktail: cocktail)
                                
                            } label: {
                                Text(cocktail.name)
                            }
                            .listRowBackground(
                                Color("MixologyDark")
                            )
                        }
                        .listStyle(PlainListStyle())
                        .font(.custom("Avenir Next", size: 22)).bold()
                        .foregroundColor(Color("MixologyColor"))
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(FavoritesViewModel())
    }
}
