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
    let imageUrl: URL
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur", type: "poison", imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
