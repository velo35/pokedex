//
//  PokemonTypeExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 2/28/24.
//

import SwiftUI

extension PokemonType
{
    var color: PokedexColor
    {
        switch self {
            case .normal: .orange
            case .fighting: .brown
            case .flying: .teal
            case .poison: .green
            case .ground: .gray
            case .rock: .brown
            case .bug: .mint
            case .ghost: .gray
            case .steel: .gray
            case .fire: .red
            case .water: .blue
            case .grass: .green
            case .electric: .yellow
            case .psychic: .purple
            case .ice: .cyan
            case .dragon: .orange
            case .dark: .gray
            case .fairy: .pink
            case .unknown: .orange
            case .shadow: .gray
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
