//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import NukeUI
import SwiftUI
import SwiftyJSON

struct PokemonDetailView: View 
{
    @Namespace var scrollOffset
    private struct ScrollOffsetPreference: PreferenceKey
    {
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
        static var defaultValue = CGRect.zero
    }
    
    @Environment(PokedexViewModel.self) var pokedexViewModel
    
    @State var flavorText = ""
    @Binding var selectedEntry: PokemonEntry?
    @State var pokemonViewModel: PokemonViewModel?
    
    var pokemon: Pokemon? { pokemonViewModel?.pokemon }
    var color: Color { pokemon?.type.color ?? .gray }
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(color.gradient)
            
            VStack {
                Text(pokemon?.name.capitalized ?? "")
                    .font(.largeTitle.weight(.medium))
                
                Text(pokemon?.type.rawValue.capitalized ?? "")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 26)
                    .background(Capsule().fill(color))
                
                
                DetailStatsView(selectedEntry: $selectedEntry)
                
                Spacer()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .background(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 30, topTrailing: 30))
                .fill(.white))
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 0) {
                        ForEach(pokedexViewModel.pokemonEntries) { entry in
                            VStack {
                                Spacer()
                                    .frame(height: 110)
                                LazyImage(url: entry.cachedPokemon?.imageUrl ?? pokemon?.imageUrl) { state in
                                    if let image = state.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 250)
                                    }
                                }
                            }
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                            .id(entry)
                        }
                    }
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreference.self,
                                    value: proxy.frame(in: .named(scrollOffset))
                                )
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo(selectedEntry)
                }
                .coordinateSpace(name: scrollOffset)
                .onPreferenceChange(ScrollOffsetPreference.self) { frame in
                    guard frame.width > 0 else { return }
                    let contentOffset = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
                    let entryOffset = CGFloat(pokedexViewModel.pokemonEntries.count) * contentOffset.x / frame.width
                    let ndx = Int(round(entryOffset))
                    selectedEntry = pokedexViewModel.pokemonEntries[ndx]
                }
            }
        }
        .onChange(of: selectedEntry, initial: true) {
            guard let selectedEntry else { return }
            pokemonViewModel = PokemonViewModel(selectedEntry)
        }
        .task {
//            print("starting task!")
//            guard let (data, response) = try? await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.name)")!) else { print("!!! - fetch"); return }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { print("!!! - response"); return }
//            guard let json = try? JSON(data: data) else { print("!!! - json"); return }
//            guard let flavor_text = json["flavor_text_entries", 0, "flavor_text"].string else { print("!!! - flavor_text"); return }
//            flavorText = flavor_text
        }
    }
}

#Preview {
    PokemonDetailView(selectedEntry: .constant(.bulbasaur))
        .environment(PokedexViewModel())
}
