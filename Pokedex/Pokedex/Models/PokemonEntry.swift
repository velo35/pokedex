//
//  PokemonEntry.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/24/23.
//

import Foundation

@Observable class PokemonEntry: Identifiable, Hashable
{
    let name: String
    let url: URL
    var pokemon: Pokemon?
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
    
    var id: URL { url }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.id)
    }
    
    static func == (lhs: PokemonEntry, rhs: PokemonEntry) -> Bool 
    {
        lhs.id == rhs.id
    }
}
