
//
//  ListView.swift
//  CatchEmAll
//
//  Created by Thomas Stack on 3/13/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var cocktailVM = ViewModel()
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        
                        NavigationStack {
                            VStack {
                                Image("CocktailsTitle")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(0.9)
                                    .foregroundColor(Color("MixologyDark"))
                                    .shadow(color: .white, radius: 2.5)
                                    .brightness(0.05)
                            }
                            .background(Color("MixologyDark"))
                            
                            List(cocktailVM.cocktailArray) { cocktail in
                                NavigationLink {
                                    DetailView(cocktail: cocktail)
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
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading:
                                                    Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("MixologyColor"))
                            }
                            )
                        }
                    }
                }
            }
        }
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
                .environmentObject(ViewModel())
        }
    }
}
