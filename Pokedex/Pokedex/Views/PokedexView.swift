//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    @State private var pokemonEntries = [PokemonEntry]()
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var body: some View
    {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(pokemonEntries, id: \.url) { entry in
                        PokemonCell(entry: entry)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
        .task {
            guard let pokemonEntries = try? await PokemonService.shared.getPokemonEntries() else { return }
            self.pokemonEntries = pokemonEntries
        }
    }
}

#Preview {
    PokedexView()
}
