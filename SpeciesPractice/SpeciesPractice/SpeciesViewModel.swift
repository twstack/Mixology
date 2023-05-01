//
//  SpeciesViewModel.swift
//  SpeciesPractice
//
//  Created by Thomas Stack on 4/28/23.
//

import Foundation

@MainActor

class SpeciesViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String? // optional because it will be null on last page
        var results: [Species]
    }

    @Published var speciesArray: [Species] = []
    @Published var isLoading = false
    var urlString = "https://swapi.dev/api/species/"
    
    func getData() async {
        isLoading = true
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not convert \(urlString) to a URL")
            isLoading = false
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data)
                print("🔍 Data from API: ", String(data: data, encoding: .utf8) ?? "N/A")
                urlString = returned.next ?? ""
                speciesArray += returned.results
                isLoading = false
            } catch {
                print("JSON ERROR: Could not convert data into JSON. \(error.localizedDescription)")
                isLoading = false
            }
        } catch {
            print("ERROR: Could not get data from urlString \(urlString)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(species: Species) async {
        guard let lastSpecies = speciesArray.last else { return }
        if lastSpecies.id == species.id && urlString != "" {
            await getData()
        }
    }
    
    func loadAll() async {
        guard urlString != "" else { return } // we're done if urlString == "". No more pages
        await getData()
        await loadAll()
    }
}
