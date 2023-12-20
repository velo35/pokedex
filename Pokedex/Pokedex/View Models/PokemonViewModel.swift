//
//  PokemonCellViewModel.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/18/23.
//

import Foundation
import Siesta
import SwiftyJSON

@Observable class PokemonViewModel
{
    let name: String
    fileprivate(set) var pokemon: Pokemon?
    
    init(_ entry: PokemonEntry) 
    {
        self.name = entry.name
        PokemonService.shared.pokemon(for: entry).addObserver(self).loadIfNeeded()
    }
}

extension PokemonViewModel: ResourceObserver
{
    func resourceChanged(_ resource: Siesta.Resource, event: Siesta.ResourceEvent) 
    {
        self.pokemon = resource.typedContent()
    }
}
