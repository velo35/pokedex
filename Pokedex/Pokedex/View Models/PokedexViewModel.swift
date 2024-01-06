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
    private(set) var pokemonEntries = [PokemonEntry]()
    private var offset = 0
    
    init()
    {
        PokemonService.shared.pokemonEntries(for: 0..<151).addObserver(self).loadIfNeeded()
    }
    
    func fetchMore()
    {
        PokemonService.shared.pokemonEntries(for: offset ..< offset + 100).addObserver(self).loadIfNeeded()
    }
    
    #if DEBUG
    func filter()
    {
        var seen = Set<PokemonType>()
        pokemonEntries = pokemonEntries.filter { entry in
            guard let pokemon: Pokemon = PokemonService.shared.pokemon(for: entry).latestData?.typedContent() else { return false }
            let result = !seen.contains(pokemon.type)
            seen.insert(pokemon.type)
            return result
        }
    }
    #endif
}

extension PokedexViewModel: ResourceObserver
{
    func resourceChanged(_ resource: Siesta.Resource, event: Siesta.ResourceEvent) 
    {
        addEntries(resource.typedContent())
    }
    
    private func addEntries(_ entries: [PokemonEntry]?) {
        guard let entries else { return }
        print("Received: \(entries.count)")
        self.pokemonEntries += entries
        self.offset += entries.count
        
        for entry in entries {
            PokemonService.shared.pokemon(for: entry).addObserver(owner: entry, closure: { resource, event in
                entry.pokemon = resource.typedContent()
            }).loadIfNeeded()
        }
    }
}
