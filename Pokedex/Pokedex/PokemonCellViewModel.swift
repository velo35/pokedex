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
    var type: String?
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
    
    func setInfo(_ json: JSON?)
    {
        guard let json,
              let type = json["types", 0, "type", "name"].string,
              let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url else { return }
        
        self.type = type
        self.imageUrl = imageUrl
    }
}
