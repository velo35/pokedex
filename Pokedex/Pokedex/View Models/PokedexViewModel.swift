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
    
    init()
    {
        PokemonService.shared.pokemonEntries.addObserver(self).loadIfNeeded()
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
        self.pokemonEntries = entries
    }
}
