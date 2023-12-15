//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokemonCell: View 
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
                    Text(pokemon.type)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            Capsule()
                                .fill(Color.white.opacity(0.25))
                        }
                        .frame(width: 100, height: 24)
                    
                    Image("bulbasaur")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                        .padding([.bottom, .trailing], 4)
                }
            }
        }
        .background(.green)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .green, radius: 6)
    }
}

#Preview {
    PokemonCell(pokemon: .bulbasaur)
}
