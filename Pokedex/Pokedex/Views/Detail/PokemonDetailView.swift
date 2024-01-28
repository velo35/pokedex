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
    @Environment(PokedexViewModel.self) var viewModel
    
    @State var flavorText = ""
    @Binding var selectedEntry: PokemonEntry?
    
    let kContentMargins: CGFloat = 0
    
    var pokemon: Pokemon {
        self.viewModel.pokemonCache[self.selectedEntry!]!
    }
    
    @State var otherColor = Color.clear
    @State private var otherEntryAmount = 0.0
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle.weight(.medium))
                
                Text(pokemon.type.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 26)
                    .background(Capsule().fill(pokemon.type.color))
                
                DetailStatsView(pokemon: pokemon)
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .padding(.bottom, 100)
            .background(.white)
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 30, topTrailing: 30)))
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.pokemonEntries) { entry in
                        HeroImageView(pokemon: viewModel.pokemonCache[entry]!)
                            .containerRelativeFrame(.horizontal)
                            .id(entry)
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
            .contentMargins(.horizontal, kContentMargins, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition(id: $selectedEntry, anchor: .center)
            .coordinateSpace(.scrollView)
            .onPreferenceChange(ScrollViewContentBounds.self) { frame in
                guard frame.width > 0 else { return }
                let contentOffsetX = -frame.origin.x
                let entriesCount = viewModel.pokemonEntries.count
                let entryOffset = CGFloat(entriesCount) * contentOffsetX / frame.width
                guard let selectedEntry,
                      let selectedIndex = viewModel.pokemonEntries.firstIndex(of: selectedEntry),
                      selectedIndex > 0 && selectedIndex < entriesCount - 1 else { otherColor = .clear; return }
                
                let offsetAmount = entryOffset.truncatingRemainder(dividingBy: 1)
                let otherEntry: PokemonEntry
                if offsetAmount < 0.5 {
                    otherEntry = viewModel.pokemonEntries[selectedIndex + 1]
                    otherEntryAmount = offsetAmount
                }
                else {
                    otherEntry = viewModel.pokemonEntries[selectedIndex - 1]
                    otherEntryAmount = (1.0 - offsetAmount)
                }
//                otherColor = PokemonService.shared.latestPokemon(for: otherEntry)?.type.color ?? .clear
            }
        }
        .background {
            Rectangle()
                .fill(pokemon.type.color.gradient)
                .overlay {
                    Rectangle()
                        .fill(otherColor.gradient)
                        .opacity(otherEntryAmount)
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
    StatefulPreviewWrapper(PokemonEntry.squirtle) {
        PokemonDetailView(selectedEntry: $0)
            .environment(PokedexViewModel())
    }
//    PokemonDetailView(selectedEntry: .constant(.squirtle))
//        .environment(viewModel())
}
