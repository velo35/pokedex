//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import Foundation
import Siesta

@Observable class PokedexViewModel
{
    var pokemonEntries = [PokemonEntry]()
    var count: Int?
    private var offset = 0
    
    init()
    {
        PokemonService.shared.pokemonEntries(for: 0..<151).addObserver(self).loadIfNeeded()
    }
    
    func fetchMore()
    {
        PokemonService.shared.pokemonEntries(for: offset ..< offset + 100).addObserver(self).loadIfNeeded()
    }
}

extension PokedexViewModel: ResourceObserver
{
    func resourceChanged(_ resource: Siesta.Resource, event: Siesta.ResourceEvent) 
    {
        setEntries(resource.typedContent())
    }
    
    private func setEntries(_ entries: PokemonEntries?) {
        guard let entries else { return }
        print("Received: \(entries.results.count)")
        self.pokemonEntries += entries.results
        self.count = entries.count
        self.offset += entries.results.count
    }
}
