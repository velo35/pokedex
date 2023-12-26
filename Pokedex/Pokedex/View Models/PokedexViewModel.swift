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
    
    private func setEntries(_ entries: [PokemonEntry]?) {
        guard let entries else { return }
        print("Received: \(entries.count)")
        self.pokemonEntries += entries
        self.offset += entries.count
    }
}
