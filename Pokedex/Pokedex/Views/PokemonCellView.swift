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
    @State var viewModel: PokemonCellViewModel
    
    init(entry: PokemonEntry)
    {
        self.viewModel = PokemonCellViewModel(entry)
    }
    
    var color: Color { viewModel.type?.color ?? .indigo }
    
    var body: some View
    {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.name.capitalized)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(viewModel.type?.rawValue ?? "")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            Capsule()
                                .fill(Color.white.opacity(0.25))
                        }
                        .frame(width: 100, height: 24)
                    
                    LazyImage(url: viewModel.imageUrl) { state in
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
        .background(color)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: color, radius: 6)
    }
}

#Preview {
    PokemonCellView(entry: .bulbasaur)
}
