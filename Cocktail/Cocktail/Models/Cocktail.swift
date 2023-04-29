import Foundation

struct Cocktail: Identifiable, Codable {
    let id = UUID().uuidString
    var idDrink: String
    var strDrink: String?
    var strInstructions: String?
    var strDrinkThumb: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?

    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strInstructions, strDrinkThumb, strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
    }

    var name: String { strDrink ?? "" }

    var instructions: String { strInstructions ?? "" }

    var ingredients: [String] {
        [strIngredient1, strIngredient2, strIngredient3, strIngredient4,
         strIngredient5, strIngredient6, strIngredient7, strIngredient8,
         strIngredient9, strIngredient10, strIngredient11, strIngredient12,
         strIngredient13, strIngredient14, strIngredient15]
            .compactMap { $0 }
    }

    var image: String { strDrinkThumb ?? "" }
}
