//
//  PokemonType.swift
//  Pokedex
//
//  Created by Scott Daniel on 2/12/24.
//

import SwiftUI

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
            case .psychic: .purple
            case .normal: .orange
            case .ground: .gray
            case .flying: .teal
            case .fairy: .pink
            default: .black
        }
    }
    
    var image: Image
    {
        switch self {
            case .fire: Image(systemName: "flame.circle.fill")
            case .grass: Image(systemName: "leaf.circle.fill")
            case .water: Image(systemName: "drop.circle.fill")
            case .electric: Image(systemName: "bolt.circle.fill")
            default: Image(systemName: "questionmark")
        }
    }
}
