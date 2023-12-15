//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation

struct Pokemon
{
    let name: String
    let type: String
    
    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur", type: "poison")
}
