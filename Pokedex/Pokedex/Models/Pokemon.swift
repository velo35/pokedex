//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation

enum PokemonType: String, Identifiable
{
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
    
    var id: PokemonType { self }
}

struct Pokemon
{
    let name: String
    let type: PokemonType
    let height: Int
    let attack: Int
    let defense: Int
    let speed: Int
    let weight: Int
    let imageUrl: URL
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur", 
                                   type: .grass,
                                   height: 7,
                                   attack: 49,
                                   defense: 49,
                                   speed: 45,
                                   weight: 69,
                                   imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
