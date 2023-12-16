//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct PokemonCell: View 
{
    let entry: PokemonEntry
    @State var pokemon: Pokemon? = nil
    
    var body: some View
    {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(entry.name.capitalized)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    if let pokemon {
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
                        
                        AsyncImage(url: pokemon.imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 68, height: 68)
                        .padding([.bottom, .trailing], 4)
                    }
                    
//                    Image("bulbasaur")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 68, height: 68)
//                        .padding([.bottom, .trailing], 4)
                }
            }
        }
        .background(.green)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .green, radius: 6)
        .task {
            do {
                pokemon = try await PokemonService.shared.getPokemon(for: entry)
            } catch PSPokemonError.decode(let reason) {
                print("decode: \(reason)")
            } catch {
                print("other pokemon error")
            }
        }
    }
}

#Preview {
    PokemonCell(entry: .bulbasaur)
}
