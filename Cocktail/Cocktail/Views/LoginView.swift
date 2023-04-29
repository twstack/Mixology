//
//  LoginView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/22/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonsDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?
    
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
                
                Image("Mixology")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .white, radius: 25)
                    .brightness(0.25)
                
                VStack {
                    Spacer()

                    Group {
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .submitLabel(.next)
                            .focused($focusField, equals: .email) // this field is bound to the .email case
                            .onSubmit {
                                focusField = .password
                            }
                            .onChange(of: email) { _ in
                                enableButtons()
                            }
                        
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.done)
                            .focused($focusField, equals: .password) // this field is bound to the .password case
                            .onSubmit {
                                focusField = nil // will dismiss the keyboard
                            }
                            .onChange(of: password) { _ in
                                enableButtons()
                            }
                    }
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }
                    .padding(.horizontal)
                    .frame(width: 350)
                    
                    HStack {
                        Button {
                            register()
                        } label: {
                            Text("Sign Up")
                        }
                        .padding(.trailing)
                        
                        Button {
                            login()
                        } label: {
                            Text("Log In")
                        }
                        .padding(.leading)
                    }
                    .disabled(buttonsDisabled)
                    .buttonStyle(.borderedProminent)
                    .font(.title2)
                    .accentColor(.gray)
                    .foregroundColor(Color("MixologyColor"))
                    .padding(.top)
                }
                .padding()
                .foregroundColor(.black)
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                }
                .onAppear {
                    // if logged in when app runs, navigate to the new screen & skip login screen
                    if Auth.auth().currentUser != nil {
                        print("🪵 Login Successful!")
                        presentSheet = true
                    }
                }
            }
            .fullScreenCover(isPresented: $presentSheet) {
                HomeView()
            }
        }
    }
    
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error { // login error occurred
                print("😡 SIGN-UP ERROR: \(error.localizedDescription)")
                alertMessage = "SIGN-UP ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("😎 Registration success!")
                presentSheet = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error { // login error occurred
                print("😡 LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("🪵 Login Successful!")
                presentSheet = true
            }
        }
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .mask(self)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ViewModel())
    }
}
