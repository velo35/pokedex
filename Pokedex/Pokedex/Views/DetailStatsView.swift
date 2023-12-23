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
    
    var body: some View
    {
        VStack(alignment: .leading) {
            Text("Stats")
                .fontWeight(.semibold)
            
            Grid(horizontalSpacing: 26) {
    #if false
                ForEach(stats, id: \.name) { stat in
                    GridRow {
                        Text(stat.name.capitalized)
                        Text("\(pokemon[keyPath: \.stat.name])")
                    }
                }
    #endif
                GridRow {
                    Text("Height")
                        .foregroundStyle(.gray)
                    
                    Text("\(pokemon.height)")
                        .fontWeight(.semibold)
                    
                    ZStack(alignment: .leading) {
                        Color.gray
                        GeometryReader { geometry in
                            Capsule()
                                .fill(.orange)
                                .frame(width: geometry.size.width * CGFloat(pokemon.height) / CGFloat(max))
                        }
                    }
                    .frame(height: 26)
                    .clipShape(Capsule())
                }
                GridRow {
                    Text("Attack")
                    Text("\(pokemon.attack)")
                    ZStack(alignment: .leading) {
                        Color.gray
                        GeometryReader { geometry in
                            Capsule()
                                .fill(.red)
                                .frame(width: geometry.size.width * CGFloat(pokemon.attack) / CGFloat(max))
                        }
                    }
                    .frame(height: 26)
                    .clipShape(Capsule())
                }
                GridRow {
                    Text("Defense")
                    Text("\(pokemon.defense)")
                    ZStack(alignment: .leading) {
                        Color.gray
                        GeometryReader { geometry in
                            Capsule()
                                .fill(.blue)
                                .frame(width: geometry.size.width * CGFloat(pokemon.defense) / CGFloat(max))
                        }
                    }
                    .frame(height: 26)
                    .clipShape(Capsule())
                }
                GridRow {
                    Text("Speed")
                    Text("\(pokemon.speed)")
                    ZStack(alignment: .leading) {
                        Color.gray
                        GeometryReader { geometry in
                            Capsule()
                                .fill(.green)
                                .frame(width: geometry.size.width * CGFloat(pokemon.speed) / CGFloat(max))
                        }
                    }
                    .frame(height: 26)
                    .clipShape(Capsule())
                }
                GridRow {
                    Text("Weight")
                    Text("\(pokemon.weight)")
                    ZStack(alignment: .leading) {
                        Color.gray
                        GeometryReader { geometry in
                            Capsule()
                                .fill(.purple)
                                .frame(width: geometry.size.width * CGFloat(pokemon.weight) / CGFloat(max))
                        }
                    }
                    .frame(height: 26)
                    .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    DetailStatsView(pokemon: .bulbasaur)
}
