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
    @State private var selected: PokemonEntry?
    @State private var typeFilter: PokemonType?
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var pokemonEntries: [PokemonEntry]
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
                        ForEach(pokemonEntries, id: \.url) { entry in
                            PokemonCellView(entry: entry)
                                .onTapGesture {
                                    withAnimation {
                                        selected = entry
                                    }
                                }
                                .matchedGeometryEffect(id: entry.name, in: animation)
                        }
                    }
                }
                
                TypeFilterView(typeFilter: $typeFilter)
                    .padding([.bottom, .trailing])
            }
            .navigationTitle("Pokemon")
        }
        .sheet(item: $selected) { entry in
            PokemonDetailView(entry: entry)
        }
    }
}

#Preview {
    PokedexView()
}
