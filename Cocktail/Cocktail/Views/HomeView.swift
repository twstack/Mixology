//
//  LoginView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/27/23.
//

import SwiftUI


struct HomeView: View {
    let images = ["image1", "image2", "image3"]
    @State private var currentIndex = 0
    @State private var listViewIsPresented = false
    @State private var mixViewIsPresented = false
    @State private var favoriteViewIsPresented = false
    @StateObject var cocktailVM = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
            }
            
            VStack {
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                Image("Mixology")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(5)
                    .shadow(color: .white, radius: 25)
                    .brightness(0.25)
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                ZStack {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.65)
                            .opacity(currentIndex == images.firstIndex(of: imageName) ? 1.0 : 0.0)
                            .animation(.easeInOut)
                            .colorMultiply(.white)
                            .brightness(0.75)
                            .shadow(color: Color("MixologyColor"), radius: 25)
                        
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.6)
                            .opacity(currentIndex == images.firstIndex(of: imageName) ? 1.0 : 0.0)
                            .animation(.easeInOut)
                        
                        
                    }
                }
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                HStack {
                    Button(action: {
                        withAnimation {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }, label: {
                        Image(systemName: "arrow.left.circle")
                            .font(.title)
                            .foregroundColor(Color("MixologyColor"))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        if currentIndex == 0 {
                            listViewIsPresented.toggle()
                        } else if currentIndex == 1 {
                            mixViewIsPresented.toggle()
                        } else {
                            favoriteViewIsPresented.toggle()
                        }
                    }, label: {
                        if currentIndex == 0 {
                            Image("FindACocktail")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(7.5)
                                .shadow(color: .white, radius: 25)
                                .brightness(0.25)
                        } else if currentIndex == 1 {
                            Image("MixYourOwn")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(7.5)
                                .shadow(color: .white, radius: 25)
                                .brightness(0.25)
                        } else {
                            Image("YourFavorites")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(7.5)
                                .shadow(color: .white, radius: 25)
                                .brightness(0.25)
                            
                        }
                    })
                    .animation(.easeIn)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            currentIndex = min(currentIndex + 1, images.count - 1)
                        }
                    }, label: {
                        Image(systemName: "arrow.right.circle")
                            .font(.title)
                            .foregroundColor(Color("MixologyColor"))
                    })
                }

                .padding()
                Button {
                    cocktailVM.logOut()
                    dismiss()
                } label: {
                    Image("LogOut")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(2)
                        .brightness(0.2)
                        .shadow(color: .red, radius: 25)
                }
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
            
            .fullScreenCover(isPresented: $listViewIsPresented) {
                NavigationStack {
                    ListView()
                }
            }
            .fullScreenCover(isPresented: $mixViewIsPresented) {
                NavigationStack {
                    MixView()
                }
            }
            .fullScreenCover(isPresented: $favoriteViewIsPresented) {
                NavigationStack {
                    FavoriteView()
                }
            }
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
