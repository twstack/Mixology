//
//  DetailView.swift
//  Cocktail
//
//  Created by Thomas Stack on 2/22/23.
//

import SwiftUI
import PhotosUI

struct DetailView: View {
    let cocktail: Cocktail
    @State private var cocktailImage = UIImage()
    @State var favorited = false
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("MixologyBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.7)
                    .opacity(0.8)
                    .blur(radius: 3)
                    .overlay {
                        Color.black.opacity(0.35)
                            .ignoresSafeArea()
                    }
                
                
                ScrollView {
                    VStack(alignment: .center) {
                        Button {
                            favorited.toggle()
                            if favorited {
                                favoritesVM.favoritedCocktails.append(cocktail)
                            } else {
                                favoritesVM.favoritedCocktails.removeAll { $0.idDrink == cocktail.idDrink }
                            }
                        } label: {
                            Text("\((cocktail.strDrink) ?? "") \(favorited ? "❤️" : "🤍")")
                                .font(.custom("Avenir Next", size: 40))
                                .padding(.bottom)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 10)
                        }
                    }
                    VStack (alignment: .leading) {
                        Text("Ingredients:")
                            .font(.custom("Avenir Next", size: 23))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(1.0), radius: 25)
                        
                        ForEach(cocktail.ingredients, id: \.self) { ingredient in
                            if ingredient != "" {
                                Text("→ " + ingredient)
                                    .font(.custom("Avenir Next", size: 18))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(1.0), radius: 25)
                            }
                        }
                        
                        Text("")
                        
                        Text("Instructions:")
                            .font(.custom("Avenir Next", size: 23))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(1.0), radius: 25)
                        
                        Text("→ " + (cocktail.strInstructions ?? "") + "\n")
                            .font(.custom("Avenir Next", size: 18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(1.0), radius: 25)
                        
                        ZStack {
                            Image(uiImage: cocktailImage)
                                .resizable()
                                .scaledToFit()
                            
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.white, lineWidth: 7.5)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                    
                }
            }
            .onAppear {
                downloadCocktailImage()
            }
        }
    }
    
    private func downloadCocktailImage() {
        guard let url = URL(string: cocktail.strDrinkThumb ?? "") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cocktailImage = image
                }
            }
        }.resume()
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(cocktail: Cocktail(idDrink: "123", strDrink: "Margarita", strInstructions: "Add salt and lime to a glass. Combine tequila, lime juice, triple sec and ice in a shaker then shake and strain into the glass.", strDrinkThumb: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg", strIngredient1: "Tequila", strIngredient2: "Triple Sec", strIngredient3: "Lime juice", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: ""))
            .environmentObject(ViewModel())
    }
}

