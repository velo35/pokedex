//
//  PokemonType.swift
//  Pokedex
//
//  Created by Scott Daniel on 2/12/24.
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
    
    var id: Self { self }
}
