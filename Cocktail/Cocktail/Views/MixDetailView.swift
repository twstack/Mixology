//
//  MixDetailView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/29/23.
//

import SwiftUI

import SwiftUI

struct MixDetailView: View {
    var mixed: Mixed

    private var name: String {
        mixed.name
    }

    private var instructions: String {
        mixed.instructions
    }

    private var ingredients: [String] {
        mixed.ingredients
    }

    private var image: UIImage? {
        mixed.uiImage
    }

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
                        Text(name)
                            .font(.custom("Avenir Next", size: 40))
                            .padding(.bottom)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10)
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Ingredients:")
                            .font(.custom("Avenir Next", size: 23))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(1.0), radius: 25)
                        
                        ForEach(ingredients, id: \.self) { ingredient in
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

                        Text("→ " + instructions + "\n")
                            .font(.custom("Avenir Next", size: 18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(1.0), radius: 25)

                        ZStack {
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                            }

                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.white, lineWidth: 7.5)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MixDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MixDetailView(mixed: Mixed(name: "Moonshot", instructions: "Add 1 oz vodka, lemon juice, ice, and shake.", ingredients: ["Vodka", "Lemon juice" ]))
        }
    }
}
