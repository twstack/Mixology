//
//  ListView.swift
//  CatchEmAll
//
//  Created by Thomas Stack on 4/22/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @StateObject var cocktailVM = ViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    @State private var sheetIsPresented = false
    
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
                        
                        List(cocktailVM.cocktailArray) { cocktail in
                            NavigationLink {
                                DetailView(cocktail: cocktail)
                                    .environmentObject(ViewModel())
                                    .environmentObject(FavoritesViewModel())
                            } label: {
                                Text(cocktail.name)
                            }
                            .id(UUID())
                            .listRowBackground(
                                Color("MixologyDark")
                            )
                        }
                        .id(UUID())
                        .listStyle(PlainListStyle())
                        .task {
                            await cocktailVM.getData()
                        }
                        .font(.custom("Avenir Next", size: 22)).bold()
                        .foregroundColor(Color("MixologyColor"))
                        .navigationBarTitleDisplayMode(.inline)
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ViewModel())
            .environmentObject(FavoritesViewModel())
    }
}
