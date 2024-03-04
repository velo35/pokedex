//
//  PokemonTypeExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 2/28/24.
//

import SwiftUI

struct PColor
{
    let r: Int
    let g: Int
    let b: Int
    
    var uiColor: UIColor {
        UIColor(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0, alpha: 1.0)
    }
}

extension PColor
{
    static let red = PColor(r: 255, g: 0, b: 0)
    static let green = PColor(r: 0, g: 255, b: 0)
    static let blue = PColor(r: 0, g: 0, b: 255)
    static let brown = PColor(r: 153, g: 102, b: 51)
    static let cyan = PColor(r: 0, g: 255, b: 255)
    static let magenta = PColor(r: 255, g: 0, b: 255)
    static let orange = PColor(r: 255, g: 127, b: 0)
    static let purple = PColor(r: 127, g: 0, b: 127)
    static let yellow = PColor(r: 255, g: 255, b: 0)
    static let lightGray = PColor(r: 170, g: 170, b: 170)
    static let gray = PColor(r: 127, g: 127, b: 127)
    
    static let mint = PColor(r: 0, g: 199, b: 190)
    static let teal = PColor(r: 48, g: 176, b: 199)
    static let lightBrown = PColor(r: 162, g: 132, b: 94)
    static let pink = PColor(r: 255, g: 45, b: 85)
    
    func lerp(_ to: Self, _ amt: Double) -> Self
    {
        let f_r = Double(self.r), l_r = Double(to.r)
        let f_g = Double(self.g), l_g = Double(to.g)
        let f_b = Double(self.b), l_b = Double(to.b)
        return PColor(
            r: Int((amt * l_r + (1.0 - amt) * f_r).rounded()),
            g: Int((amt * l_g + (1.0 - amt) * f_g).rounded()),
            b: Int((amt * l_b + (1.0 - amt) * f_b).rounded())
        )
    }
}

extension PokemonType
{
    var color: PColor
    {
        switch self {
            case .normal: .orange
            case .fighting: .lightBrown
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
