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

extension PokemonType
{
    var color: Color
    {
        switch self {
            case .fire: .red
            case .grass: .green
            case .bug: .mint
            case .water: .blue
            case .electric: .yellow
            case .pyschic: .purple
            case .normal: .orange
            case .ground: .gray
            case .flying: .teal
            case .fairy: .pink
        }
    }
}

struct Pokemon
{
    let name: String
    let type: PokemonType
    let imageUrl: URL
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur", type: .grass, imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
