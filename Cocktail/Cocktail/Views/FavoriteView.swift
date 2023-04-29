//
//  FavoriteView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/28/23.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var cocktailVM = ViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                        
                        if favoritesVM.favoritedCocktails.isEmpty {
                            Spacer()
                            overlay {
                                Color("MixologyDark")
                                    .ignoresSafeArea()
                            }
                        } else {
                            ZStack {
                                overlay {
                                    Color("MixologyDark")
                                        .ignoresSafeArea()
                                }
                                List(favoritesVM.favoritedCocktails) { cocktail in
                                    NavigationLink {
                                        DetailView(cocktail: cocktail)
                                            .environmentObject(cocktailVM)
                                            .environmentObject(favoritesVM)
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
                }
            }
        }
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    })
                )
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(FavoritesViewModel())
    }
}
