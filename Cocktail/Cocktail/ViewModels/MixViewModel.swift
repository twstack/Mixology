//
//  MixViewModel.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/29/23.
//

import Foundation
@MainActor
class MixViewModel: ObservableObject {
    @Published var mixedDrinks: [Mixed] = []

    func addMixedDrink(_ mixedDrink: Mixed) {
        mixedDrinks.append(mixedDrink)
    }

    func removeMixedDrink(at offsets: IndexSet) {
        mixedDrinks.remove(atOffsets: offsets)
    }
}
