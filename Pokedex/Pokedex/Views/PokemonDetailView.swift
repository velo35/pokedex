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
    
    typealias Stat = (name: String, color: Color)
    
    let stats: [Stat] = [
        ("height", Color.orange),
        ("attack", Color.red),
        ("defense", Color.blue),
        ("speed", Color.cyan),
        ("weight", Color.purple)
    ]
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            Rectangle().fill(pokemon.type.color.gradient)
            
            VStack {
                Spacer()
                //image
                
                VStack {
                    Grid {
                        ForEach(stats, id: \.name) { stat in
                            GridRow {
                                Text(stat.name.capitalized)
//                                Text("\(pokemon[keyPath: \.stat.name])")
                            }
                        }
                    }
                }
                .background(.white)
            }
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: .bulbasaur)
}
