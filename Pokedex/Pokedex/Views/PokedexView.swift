//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokedexView: View 
{
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var body: some View
    {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16) {
                    ForEach(0..<151) { _ in
                        PokemonCell(pokemon: .bulbasaur)
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
