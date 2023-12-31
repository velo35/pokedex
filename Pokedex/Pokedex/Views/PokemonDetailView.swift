//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

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
    @State var pokemonViewModel: PokemonViewModel
    
    init(selectedEntry: Binding<PokemonEntry?>)
    {
        _selectedEntry = selectedEntry
        _pokemonViewModel = State(wrappedValue: PokemonViewModel(selectedEntry.wrappedValue!))
    }
    
    var color: Color { pokemonViewModel.pokemon?.type.color ?? .gray }
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(color.gradient)
            
            VStack {
                Text(pokemonViewModel.name.capitalized)
                    .font(.largeTitle.weight(.medium))
                
                Text(pokemonViewModel.pokemon?.type.rawValue.capitalized ?? "")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 26)
                    .background(Capsule().fill(color))
                
                
                DetailStatsView(viewModel: pokemonViewModel)
                
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
                                    .frame(height: 50)
                                HeroImageView(entry: entry)
                            }
                            .containerRelativeFrame(.horizontal)
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
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, 40, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo(selectedEntry)
                }
                .coordinateSpace(name: scrollOffset)
                .onPreferenceChange(ScrollOffsetPreference.self) { frame in
                    guard frame.width > 0 else { return }
                    let contentOffsetX = -frame.origin.x
                    let entryOffset = CGFloat(pokedexViewModel.pokemonEntries.count) * contentOffsetX / frame.width
                    let ndx = Int(round(entryOffset))
                    let newEntry = pokedexViewModel.pokemonEntries[ndx]
                    selectedEntry = newEntry
                    pokemonViewModel = PokemonViewModel(newEntry)
                }
            }
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
    StatefulPreviewWrapper(PokemonEntry.bulbasaur) {
        PokemonDetailView(selectedEntry: $0)
            .environment(PokedexViewModel())
    }
}
