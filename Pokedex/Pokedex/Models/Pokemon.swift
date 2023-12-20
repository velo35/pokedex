//
//  Pokemon.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import SwiftUI

enum PokemonType: String
{
    case fire
    case grass
    case bug
    case water
    case electric
    case pyschic
    case normal
    case ground
    case flying
    case fairy
}

@Observable class Pokemon
{
    let name: String
    let type: PokemonType
    let imageUrl: URL
    
    init(name: String, type: PokemonType, imageUrl: URL) {
        self.name = name
        self.type = type
        self.imageUrl = imageUrl
    }
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur", type: .grass, imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
