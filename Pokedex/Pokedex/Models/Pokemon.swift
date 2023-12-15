//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation

struct Pokemon: Identifiable, Codable
{
    let id: Int
    let name: String
}

extension Pokemon
{
    static let bulbasaur = Pokemon(id: 1, name: "bulbasaur")
}
