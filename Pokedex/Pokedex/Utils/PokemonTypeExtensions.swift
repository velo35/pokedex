//
//  PokemonTypeExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/19/23.
//

import SwiftUI

extension PokemonType: Identifiable
{
    var id: PokemonType {
        self
    }
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
