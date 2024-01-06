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
    let entry: PokemonEntry
    
    var body: some View
    {
        LazyImage(url: entry.pokemon?.imageUrl) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    HeroImageView(entry: .bulbasaur)
}
