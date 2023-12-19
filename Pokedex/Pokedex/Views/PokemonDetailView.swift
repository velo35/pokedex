//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import SwiftUI

struct PokemonDetailView: View 
{
    let pokemon: Pokemon
    
    var body: some View
    {
        VStack {
            ZStack {
                
            }
            .background(pokemon.type.color)
            
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: .bulbasaur)
}
