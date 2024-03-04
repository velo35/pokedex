//
//  PokedexColor.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/4/24.
//

import SwiftUI

struct PokedexColor
{
    let r: Int
    let g: Int
    let b: Int
    
    var uiColor: UIColor {
        UIColor(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0, alpha: 1.0)
    }
}

extension PokedexColor
{
    enum Basic {
        static let red = PokedexColor(r: 255, g: 0, b: 0)
        static let green = PokedexColor(r: 0, g: 255, b: 0)
        static let blue = PokedexColor(r: 0, g: 0, b: 255)
        static let brown = PokedexColor(r: 153, g: 102, b: 51)
        static let cyan = PokedexColor(r: 0, g: 255, b: 255)
        static let magenta = PokedexColor(r: 255, g: 0, b: 255)
        static let orange = PokedexColor(r: 255, g: 127, b: 0)
        static let purple = PokedexColor(r: 127, g: 0, b: 127)
        static let yellow = PokedexColor(r: 255, g: 255, b: 0)
        static let lightGray = PokedexColor(r: 170, g: 170, b: 170)
        static let gray = PokedexColor(r: 127, g: 127, b: 127)
    }
    
    static let red = PokedexColor(r: 255, g: 59, b: 48)
    static let orange = PokedexColor(r: 255, g: 149, b: 0)
    static let yellow = PokedexColor(r: 255, g: 204, b: 0)
    static let green = PokedexColor(r: 52, g: 199, b: 89)
    static let mint = PokedexColor(r: 0, g: 199, b: 190)
    static let teal = PokedexColor(r: 48, g: 176, b: 199)
    static let cyan = PokedexColor(r: 50, g: 173, b: 230)
    static let blue = PokedexColor(r: 0, g: 122, b: 255)
    static let indigo = PokedexColor(r: 88, g: 86, b: 214)
    static let purple = PokedexColor(r: 175, g: 82, b: 222)
    static let pink = PokedexColor(r: 255, g: 45, b: 85)
    static let brown = PokedexColor(r: 162, g: 132, b: 94)
    
    static let gray = PokedexColor(r: 142, g: 142, b: 147)
    
    func lerp(_ to: Self, _ amt: Double) -> Self
    {
        let f_r = Double(self.r), l_r = Double(to.r)
        let f_g = Double(self.g), l_g = Double(to.g)
        let f_b = Double(self.b), l_b = Double(to.b)
        return PokedexColor(
            r: Int((amt * l_r + (1.0 - amt) * f_r).rounded()),
            g: Int((amt * l_g + (1.0 - amt) * f_g).rounded()),
            b: Int((amt * l_b + (1.0 - amt) * f_b).rounded())
        )
    }
}
