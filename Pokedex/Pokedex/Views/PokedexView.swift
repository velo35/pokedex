//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    @Environment(PokedexViewModel.self) var viewModel
    
    @Namespace var animation
    
    @State private var selectedEntry: PokemonEntry?
    @State private var typeFilter: PokemonType?
    
    @State private var detailShown = false
    
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
                        ForEach(filteredPokemonEntries) { entry in
                            PokemonCellView(entry: entry)
                                .onTapGesture {
                                    selectedEntry = entry
                                    detailShown = true
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
        .sheet(isPresented: $detailShown) {
            PokemonDetailView(selectedEntry: $selectedEntry)
        }
    }
}

#Preview {
    PokedexView()
        .environment(PokedexViewModel())
}
