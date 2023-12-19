//
//  PokemonCellViewModel.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import Foundation
import Siesta
import SwiftyJSON

@Observable class PokemonCellViewModel
{
    let name: String
    var type: PokemonType?
    var imageUrl: URL?
    
    init(_ entry: PokemonEntry) 
    {
        self.name = entry.name
        PokemonService.shared.pokemon(for: entry).addObserver(self).loadIfNeeded()
    }
}

extension PokemonCellViewModel: ResourceObserver
{
    func resourceChanged(_ resource: Siesta.Resource, event: Siesta.ResourceEvent) 
    {
        setInfo(resource.typedContent())
    }
    
    func setInfo(_ pokemon: Pokemon?)
    {
        guard let pokemon else { return }
        
        self.type = pokemon.type
        self.imageUrl = pokemon.imageUrl
    }
}
