//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import SwiftUI
import SwiftyJSON

fileprivate struct ScrollViewContentBounds: PreferenceKey
{
    static var defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

fileprivate extension CoordinateSpace
{
    static var scrollView = Self.named("ScrollViewContentBounds")
}

struct PokemonDetailView: View 
{
    let viewModel = PokedexViewModel.shared

    @Binding var selectedEntry: PokemonEntry?
    @State private var backgroundColor = Color.clear
    //    @State var flavorText = ""
    
    private var pokemon: Pokemon
    {
        self.viewModel.pokemonCache[selectedEntry!]!
    }
    
    private var detailStatsView: some View
    {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.largeTitle.weight(.medium))
            
            Text(pokemon.type.rawValue.capitalized)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 26)
                .background(Capsule().fill(Color(pokemon.type.color.uiColor)))
            
            DetailStatsView(pokemon: pokemon)
        }
        .padding(.horizontal)
        .padding(.top, 50)
        .padding(.bottom, 100)
        .background(.white)
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 30, topTrailing: 30)))
    }
    
    private var heroImageScrollView: some View
    {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(viewModel.pokemonEntries) { entry in
                    VStack {
                        if let pokemon = viewModel.pokemonCache[entry] {
                            HeroImageView(pokemon: pokemon)
                        }
                    }
                    .containerRelativeFrame(.horizontal)
                    .padding(.bottom, 390)
                }
            }
            .scrollTargetLayout()
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: ScrollViewContentBounds.self,
                            value: proxy.frame(in: .scrollView)
                        )
                }
            }
        }
        .contentMargins(.horizontal, 40, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollPosition(id: $selectedEntry, anchor: .center)
        .coordinateSpace(.scrollView)
        .onPreferenceChange(ScrollViewContentBounds.self) { frame in
            let contentOffsetX = -frame.origin.x
            guard frame.width > 0 && contentOffsetX > 0 && contentOffsetX < frame.size.width else { return }
            
            let entriesCount = viewModel.pokemonEntries.count
            let entryOffset = Double(entriesCount) * contentOffsetX / frame.width
            let offsetAmount = entryOffset.truncatingRemainder(dividingBy: 1)
            let firstIndex = Int(entryOffset.rounded(.down))
            let secondIndex = Int(entryOffset.rounded(.up))
            guard secondIndex < entriesCount,
                  let firstPokemon = viewModel.pokemonCache[viewModel.pokemonEntries[firstIndex]],
                  let secondPokemon = viewModel.pokemonCache[viewModel.pokemonEntries[secondIndex]] else { return }
            
            let firstColor = firstPokemon.type.color
            let secondColor = secondPokemon.type.color
            
            backgroundColor = Color(firstColor.lerp(secondColor, offsetAmount).uiColor)
        }
    }
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            backgroundColor
            
            detailStatsView
            
            heroImageScrollView
        }
        .task {
        //            print("starting task!")
        //            guard let (data, response) = try? await URLSession.shared.data(from: URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.name)")!) else { print("!!! - fetch"); return }
        //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { print("!!! - response"); return }
        //            guard let json = try? JSON(data: data) else { print("!!! - json"); return }
        //            guard let flavor_text = json["flavor_text_entries", 0, "flavor_text"].string else { print("!!! - flavor_text"); return }
        //            flavorText = flavor_text
        }
        .onAppear {
            backgroundColor = Color(pokemon.type.color.uiColor)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(PokemonEntry.bulbasaur) {
        PokemonDetailView(selectedEntry: $0)
    }
}
