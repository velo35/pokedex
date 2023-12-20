//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import SwiftUI

struct PokemonDetailView: View 
{
    @State var viewModel: PokemonViewModel
    
    init(entry: PokemonEntry)
    {
        self.viewModel = PokemonViewModel(entry)
    }
    
    var body: some View
    {
        VStack {
            ZStack {
                
            }
//            .background(pokemon.type.color)
            
        }
    }
}

#Preview {
    PokemonDetailView(entry: .bulbasaur)
}
