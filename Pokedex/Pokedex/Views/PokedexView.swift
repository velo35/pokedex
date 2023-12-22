//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    @Namespace var animation
    @State private var viewModel = PokedexViewModel()
    @State private var selected: Pokemon?
    @State private var typeFilter: PokemonType?
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var filteredPokemonEntries: [PokemonEntry]
    {
        guard let typeFilter else { return viewModel.pokemonEntries }
        return viewModel.pokemonEntries.filter { entry in
            (PokemonService.shared.pokemon(for: entry).latestData?.content as? Pokemon)?.type == typeFilter
        }
    }
    
    var body: some View
    {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(filteredPokemonEntries, id: \.url) { entry in
                            PokemonCellView(entry: entry)
                                .onTapGesture {
                                    withAnimation {
                                        if let pokemon: Pokemon = PokemonService.shared.latestPokemon(for: entry) {
                                            selected = pokemon
                                        }
                                    }
                                }
                                .matchedGeometryEffect(id: entry.name, in: animation)
                        }
                    }
                    Button("Load More") {
                        viewModel.fetchMore()
                    }
                }
                
                TypeFilterView(typeFilter: $typeFilter)
                    .padding([.bottom, .trailing])
                    .padding([.bottom])
            }
            .navigationTitle("Pokemon")
        }
        .sheet(item: $selected) { pokemon in
            PokemonDetailView(pokemon: pokemon)
        }
    }
}

#Preview {
    PokedexView()
}
