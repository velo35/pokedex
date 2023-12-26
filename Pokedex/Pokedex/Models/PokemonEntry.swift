//
//  PokemonEntry.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/24/23.
//

import Foundation

struct PokemonEntry: Identifiable, Codable, Equatable, Hashable
{
    let name: String
    let url: URL
    
    var id: URL { url }
}

extension PokemonEntry
{    
    static let bulbasaur = PokemonEntry(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
}
