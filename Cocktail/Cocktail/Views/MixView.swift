//
//  MixView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/28/23.
//

import SwiftUI

struct MixView: View {
    @StateObject var mixVM = MixViewModel()
    @State private var showingAddMixView = false
    @State private var editMode = EditMode.inactive
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    NavigationStack {
                        VStack {
                            Image("MixedTitle")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.9)
                                .padding()
                                .foregroundColor(Color("MixologyDark"))
                                .shadow(color: .white, radius: 2.5)
                                .brightness(0.05)
                        }
                        .background(Color("MixologyDark"))
                        
                        if mixVM.mixedDrinks.isEmpty {
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
                                List {
                                    ForEach(mixVM.mixedDrinks) { cocktail in
                                        NavigationLink(destination: MixDetailView(mixed: cocktail).environmentObject(mixVM)) {
                                            Text(cocktail.name)
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteCocktail)
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
        
        .navigationBarItems(leading: EditButton(), trailing: Button(action: {
            showingAddMixView = true
        }) {
            Image(systemName: "plus")
        })
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $showingAddMixView) {
            AddMixView()
        }
    }
    
    private func deleteCocktail(at offsets: IndexSet) {
        mixVM.mixedDrinks.remove(atOffsets: offsets)
    }
}

struct MixView_Previews: PreviewProvider {
    static var previews: some View {
        MixView()
            .environmentObject(MixViewModel())
    }
}
