//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation

enum PokemonType: String
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
}

@Observable class Pokemon: Identifiable
{
    let id: Int
    let name: String
    let type: PokemonType
    let height: Int
    let attack: Int
    let defense: Int
    let speed: Int
    let weight: Int
    let imageUrl: URL
    
    init(id: Int, name: String, type: PokemonType, height: Int, attack: Int, defense: Int, speed: Int, weight: Int, imageUrl: URL) {
        self.id = id
        self.name = name
        self.type = type
        self.height = height
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.weight = weight
        self.imageUrl = imageUrl
    }
}

extension Pokemon
{
    static let bulbasaur = Pokemon(id: 1,
                                   name: "bulbasaur", 
                                   type: .grass,
                                   height: 7,
                                   attack: 49,
                                   defense: 49,
                                   speed: 45,
                                   weight: 69,
                                   imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
