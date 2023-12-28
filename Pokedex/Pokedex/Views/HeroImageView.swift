//
//  HeroImageView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/28/23.
//

import SwiftUI
import NukeUI

struct HeroImageView: View 
{
    private var viewModel: PokemonViewModel
    
    init(entry: PokemonEntry)
    {
        self.viewModel = PokemonViewModel(entry)
    }
    
    var body: some View
    {
        LazyImage(url: viewModel.pokemon?.imageUrl) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
        }
    }
}

#Preview {
    HeroImageView(entry: .bulbasaur)
}
