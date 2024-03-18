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
    static let shared = PokedexViewModel()
    
    private(set) var pokemonEntries = [PokemonEntry]()
    private(set) var pokemonCache = [PokemonEntry: Pokemon]()
    
    var allFetched: Bool {
        self.count == self.pokemonEntries.count
    }
    
    private var count = 0
    
    private init()
    {
        PokemonService.shared.pokemonEntries(for: 0 ..< 151).addObserver(self).loadIfNeeded()
    }
    
    func fetchAll()
    {
        if self.count > 0 {
            PokemonService.shared.pokemonEntries(for: 0 ..< self.count).addObserver(self).loadIfNeeded()
        }
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
        guard let request: PokemonService.PokemonRequest = resource.typedContent() else { return }
        self.pokemonEntries = request.results
        self.count = request.count
        
        for entry in self.pokemonEntries {
            PokemonService.shared.pokemon(for: entry).addObserver(owner: self, closure: { resource, event in
                if let pokemon: Pokemon = resource.typedContent() {
                    self.pokemonCache[entry] = pokemon
                }
            }).loadIfNeeded()
        }
    }
}
