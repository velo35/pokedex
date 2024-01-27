//
//  PokemonEntry.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/24/23.
//

import Foundation

struct PokemonEntry: Identifiable, Hashable
{
    let name: String
    let url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    var id: URL { url }
}
