//
//  FavoriteViewModel.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/28/23.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoritedCocktails: [Cocktail] = []
}
