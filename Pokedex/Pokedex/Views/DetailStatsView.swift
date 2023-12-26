//
//  StatsView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/22/23.
//

import SwiftUI

struct DetailStatsView: View 
{
    let pokemon: Pokemon
    
    let max = 150
    
    typealias Stat = (name: String, keyPath: KeyPath<Pokemon, Int>, color: Color)
    
    let stats: [Stat] = [
        ("height", \Pokemon.height, Color.orange),
        ("attack", \Pokemon.attack, Color.red),
        ("defense", \Pokemon.defense, Color.blue),
        ("speed", \Pokemon.speed, Color.cyan),
        ("weight", \Pokemon.weight, Color.purple)
    ]
    
    func row(_ stat: Stat) -> some View
    {
        GridRow {
            Text(stat.name.capitalized)
                .foregroundStyle(.gray)
            
            Text("\(pokemon[keyPath: stat.keyPath])")
                .fontWeight(.semibold)
            
            ZStack(alignment: .leading) {
                Rectangle().fill(Color.black.opacity(0.45).gradient)
                GeometryReader { geometry in
                    Capsule()
                        .fill(stat.color.gradient)
                        .frame(width: geometry.size.width * CGFloat(pokemon[keyPath: stat.keyPath]) / CGFloat(max))
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
            
            Grid(horizontalSpacing: 26) {
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