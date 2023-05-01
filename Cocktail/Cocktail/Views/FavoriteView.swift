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
        NavigationStack {
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        NavigationStack {
                            VStack {
                                Image("FavoritesTitle")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(0.9)
                                    .padding()
                                    .foregroundColor(Color("MixologyDark"))
                                    .shadow(color: .white, radius: 2.5)
                                    .brightness(0.05)
                            }
                            .background(Color("MixologyDark"))
                            
                            ZStack {
                                overlay {
                                    Color("MixologyDark")
                                        .ignoresSafeArea()
                                }
                                List {
                                    ForEach(favoritesVM.favoritedCocktails) { cocktail in
                                        NavigationLink(destination: DetailView(cocktail: cocktail).environmentObject(favoritesVM)) {
                                            Text(cocktail.name)
                                        }
                                    }
                                }
                                .listStyle(PlainListStyle())
                                .font(.custom("Avenir Next", size: 22)).bold()
                                .foregroundColor(Color("MixologyColor"))
                            }
                        }
                    }
                    .background(Color("MixologyDark"))
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FavoriteView()
                .environmentObject(FavoritesViewModel())
        }
    }
}
