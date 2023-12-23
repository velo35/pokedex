//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import NukeUI
import SwiftUI
import SwiftyJSON

extension Color
{
    static var random: Color
    {
        Color(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1)
    }
}

struct PokemonDetailView: View 
{
    @Environment(PokedexViewModel.self) var viewModel
    
    let pokemon: Pokemon
    @State var flavorText = ""
    
    let colors: [Color] = [.red, .green, .blue, .purple, .pink, .cyan, .orange, .brown, .cyan, .indigo]
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(pokemon.type.color.gradient)
            
            VStack {
//                Spacer(minLength: 45)
                Text(pokemon.name.capitalized)
                    .font(.largeTitle.weight(.medium))
                
                Text(pokemon.type.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 26)
                    .background(Capsule().fill(pokemon.type.color))
                
                DetailStatsView(pokemon: pokemon)
                
                Spacer()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 30, topTrailing: 30))
                .fill(.white))
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ForEach(viewModel.pokemonEntries) { entry in
                        LazyImage(url: entry.pokemon?.imageUrl) { state in
                            if let image = state.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                        .offset(y: 100)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
        .task {
            print("starting task!")
            guard let (data, response) = try? await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.name)")!) else { print("!!! - fetch"); return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { print("!!! - response"); return }
            guard let json = try? JSON(data: data) else { print("!!! - json"); return }
            guard let flavor_text = json["flavor_text_entries", 0, "flavor_text"].string else { print("!!! - flavor_text"); return }
            flavorText = flavor_text
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: .bulbasaur)
        .environment(PokedexViewModel())
}
