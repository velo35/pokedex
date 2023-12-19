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
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var body: some View
    {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(viewModel.pokemonEntries, id: \.url) { entry in
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
                .navigationTitle("Pokemon")
                
                if let selected {
                    
                }
            }
        }
    }
}

#Preview {
    PokedexView()
}
