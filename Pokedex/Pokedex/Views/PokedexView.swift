//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    @State private var pokemons = [Pokemon]()
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var body: some View
    {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(pokemons) { pokemon in
                        PokemonCell(pokemon: pokemon)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
        .task {
            guard let pokemonEntries = try? await PokemonService.shared.getPokemonEntries() else { return }
            for entry in pokemonEntries {
                if let pokemon = try? await PokemonService.shared.getPokemon(for: entry) {
                    pokemons.append(pokemon)
                }
            }
        }
    }
}

#Preview {
    PokedexView()
}
