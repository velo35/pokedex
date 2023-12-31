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
    @State var viewModel: PokemonViewModel
    
    var pokemon: Pokemon? { viewModel.pokemon }
    var color: Color { pokemon?.type.color ?? .gray }
    
    var body: some View
    {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(pokemon?.name.capitalized ?? "")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(pokemon?.type.rawValue ?? "")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            Capsule()
                                .fill(Color.white.opacity(0.25))
                        }
                        .frame(width: 100, height: 24)
                    
                    LazyImage(url: pokemon?.imageUrl) { state in
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
            .opacity(pokemon != nil ? 1 : 0)
        }
        .background(color)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: color, radius: 6)
        .overlay {
            if pokemon == nil {
                ProgressView()
                    .scaleEffect(3)
            }
        }
    }
}

#Preview {
    PokemonCellView(viewModel: PokemonViewModel(.bulbasaur))
}
