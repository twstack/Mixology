//
//  MixDetailView.swift
//  Cocktail
//
//  Created by Thomas Stack on 4/29/23.
//

import SwiftUI

struct AddMixView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var mixViewModel = MixViewModel()
    @State private var name: String = ""
    @State private var instructions: String = ""
    @State private var ingredients: [String] = []
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        ZStack {
            NavigationView {
                
                Form {
                    Section(header: Text("Cocktail Name")) {
                        TextField("Enter cocktail name", text: $name)
                    }
                    
                    Section(header: Text("Instructions")) {
                        TextField("Enter instructions", text: $instructions)
                    }
                    
                    Section(header: Text("Ingredients")) {
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            TextField("Ingredient \(index + 1)", text: $ingredients[index])
                        }
                        
                        Button {
                            ingredients.append("")
                        } label: {
                            Label("Add Ingredient", systemImage: "plus")
                        }
                    }
                    
                    Section(header: Text("Image")) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("Tap to select an image")
                                .foregroundColor(.gray)
                        }
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
                }
                .foregroundColor(Color("MixologyDark"))
                .frame(alignment: .center)
                .navigationTitle("Add Mixed Drink")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let mixedDrink = Mixed(name: name,
                                                   instructions: instructions,
                                                   ingredients: ingredients.filter { !$0.isEmpty },
                                                   imageData: image?.jpegData(compressionQuality: 1.0))
                            mixViewModel.addMixedDrink(mixedDrink)
                            dismiss()
                        }
                        .disabled(name.isEmpty || instructions.isEmpty || ingredients.count < 1 || image == nil)
                    }
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $image)
                }

            }
            .font(.custom("Avenir Next", size: 17))
        }
    }
    
    
    func loadImage() {

    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.dismiss()
        }
    }
}

struct AddMixView_Previews: PreviewProvider {
    static var previews: some View {
        AddMixView()
            .environmentObject(MixViewModel())
    }
}
