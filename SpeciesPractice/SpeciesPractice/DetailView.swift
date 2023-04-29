//
//  DetailView.swift
//  SpeciesPractice
//
//  Created by Thomas Stack on 4/28/23.
//

import SwiftUI

struct DetailView: View {
    let species: Species
    var body: some View {
        VStack(alignment: .leading) {
            Text(species.name)
                .font(.largeTitle)
                .bold()
            Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
            
            Group {
                HStack(alignment: .top) {
                    Text("Classification")
                        .bold()
                    Text(species.classification)
                }
                HStack(alignment: .top) {
                    Text("Height:")
                        .bold()
                    Text(species.average_height)
                    Spacer()
                    Text("Lifespan:")
                        .bold()
                    Text(species.average_lifespan)
                }
                HStack(alignment: .top) {
                    Text("Language:")
                        .bold()
                    Text(species.language)
                }
                HStack(alignment: .top) {
                    Text("Skin Colors:")
                        .bold()
                    Text(species.skin_colors)
                }
                HStack(alignment: .top) {
                    Text("Hair Colors:")
                        .bold()
                    Text(species.hair_colors)
                }
                HStack(alignment: .top) {
                    Text("Eye Colors:")
                        .bold()
                    Text(species.eye_colors)
                }
            }
            .font(.title2)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(species: Species(name: "Swifter", classification: "Coder", designation: "sentient", average_height: "75", average_lifespan: "83", language: "Swift", skin_colors: "Swift", hair_colors: "various or none", eye_colors: "various"))
    }
}
