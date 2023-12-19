//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    @State private var viewModel = PokedexViewModel()
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var body: some View
    {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(viewModel.pokemonEntries, id: \.url) { entry in
                        PokemonCellView(entry: entry)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
    }
}

#Preview {
    PokedexView()
}
