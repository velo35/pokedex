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
    let pokemon: Pokemon
    
    var body: some View
    {
        LazyImage(url: pokemon.imageUrl) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    HeroImageView(pokemon: .bulbasaur)
}
