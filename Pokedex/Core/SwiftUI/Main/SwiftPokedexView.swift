//
//  PokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import SwiftUI

struct SwiftPokedexView: View 
{
    let viewModel = PokedexViewModel.shared
    
    @State private var selectedEntry: PokemonEntry?
    @State private var typeFilter: PokemonType?
    @State private var detailShown = false
    
    private let gridItems: [GridItem] = [.init(.flexible()), .init(.flexible())]
    
    var filteredPokemonEntries: [PokemonEntry]
    {
        guard let typeFilter else { return viewModel.pokemonEntries }
        return viewModel.pokemonEntries.filter { entry in
            guard let pokemon = self.viewModel.pokemonCache[entry] else { return false }
            return pokemon.type == typeFilter
        }
    }
    
    var progressView: some View
    {
        ProgressView()
            .scaleEffect(3)
            .frame(width: 180, height: 100)
            .background {
                Color.gray
            }
            .clipShape(.rect(cornerRadius: 12))
            .shadow(color: .gray, radius: 6)
    }
    
    var body: some View
    {
        ZStack(alignment: .bottomTrailing) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(filteredPokemonEntries) { entry in
                            if let pokemon = viewModel.pokemonCache[entry] {
                                PokemonCellView(pokemon: pokemon)
                                    .onTapGesture {
                                        selectedEntry = entry
                                        detailShown = true
                                    }
                                    .sheet(isPresented: $detailShown) {
                                        selectedEntry = nil
                                    } content: {
                                        PokemonDetailView(selectedEntry: $selectedEntry)
                                    }
                            }
                            else {
                                progressView
                            }
                        }
                    }
                    
                    Button {
                        viewModel.fetchAll()
                    } label: {
                        Text("Load All")
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background {
                                Color.blue
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                    }
                }
                .onChange(of: selectedEntry) {
                    if let selectedEntry {
                        proxy.scrollTo(selectedEntry, anchor: .center)
                    }
                }
            }
            
            TypeFilterView(typeFilter: $typeFilter)
                .padding([.bottom, .trailing])
                .padding(.bottom)
        }
    }
}

#Preview {
    SwiftPokedexView()
}
