//
//  StatsView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/22/23.
//

import SwiftUI
import UIKit

struct DetailStatsView: View 
{
    var pokemon: Pokemon?
    
    private let max = 150
    
    typealias Stat = (name: String, keyPath: KeyPath<Pokemon, Int>, color: Color)
    
    let stats: [Stat] = [
        ("height", \Pokemon.height, Color.orange),
        ("attack", \Pokemon.attack, Color.red),
        ("defense", \Pokemon.defense, Color.blue),
        ("speed", \Pokemon.speed, Color.cyan),
        ("weight", \Pokemon.weight, Color.purple)
    ]
    
    func amount(for keyPath: KeyPath<Pokemon, Int>) -> Int
    {
        guard let pokemon else { return 0}
        return pokemon[keyPath: keyPath]
    }
    
    func row(_ stat: Stat) -> some View
    {
        GridRow {
            Text(stat.name.capitalized)
                .foregroundStyle(.gray)
            
            ZStack {
                Text("00000")
                    .hidden()
                Text("\(amount(for: stat.keyPath))")
                    .fontWeight(.semibold)
            }
            
            ZStack(alignment: .leading) {
                Rectangle().fill(Color.black.opacity(0.45).gradient)
                GeometryReader { geometry in
                    Capsule()
                        .fill(stat.color.gradient)
                        .frame(width: geometry.size.width * CGFloat(amount(for: stat.keyPath)) / CGFloat(max))
                        .animation(.default, value: amount(for: stat.keyPath))
                }
            }
            .frame(height: 26)
            .clipShape(Capsule())
        }
    }
    
    var body: some View
    {
        VStack(alignment: .leading) {
            Text("Stats")
                .fontWeight(.semibold)
            
            Grid(horizontalSpacing: 20) {
                ForEach(stats, id: \.name) { stat in
                    row(stat)
                }
            }
        }
    }
}

#Preview {
    DetailStatsView(pokemon: .bulbasaur)
}
