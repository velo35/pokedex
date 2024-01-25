//
//  ContentView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct ContentView: View 
{
    var body: some View
    {
        SideMenuView(
            main: NavigationStack {
                PokedexView()
                    .navigationTitle("Pokemon")
            },
            side: OptionsPanel()
        )
    }
}

#Preview {
    ContentView()
        .environment(PokedexViewModel())
}
