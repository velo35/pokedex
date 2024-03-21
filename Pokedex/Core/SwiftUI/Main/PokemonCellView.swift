//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI
import NukeUI

struct PokemonCellView: View 
{
    let pokemon: Pokemon
    
    var body: some View
    {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(pokemon.type.rawValue)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            Capsule()
                                .fill(Color.white.opacity(0.25))
                        }
                        .frame(width: 100, height: 24)
                    
                    LazyImage(url: pokemon.imageUrl) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFit()
                        }
                        else if state.error != nil {
                            Color.red
                        }
                        else {
                            ProgressView()
                        }
                    }
                    .frame(width: 68, height: 68)
                    .padding([.bottom, .trailing], 4)
                }
            }
        }
        .background(Color(pokemon.type.color.uiColor))
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: Color(pokemon.type.color.uiColor), radius: 6)
    }
}

#Preview {
    PokemonCellView(pokemon: .bulbasaur)
}
