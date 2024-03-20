//
//  UIKitPokedexView.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/19/24.
//

import SwiftUI

struct UIKitPokedexView: View 
{
    @State private var selectedEntry: PokemonEntry?
    @State private var detailShown = false
    
    var body: some View
    {
        PokedexViewControllerView() { entry in
            selectedEntry = entry
            detailShown = true
        }
        .sheet(isPresented: $detailShown) {
            selectedEntry = nil
        } content: {
            PokemonDetailView(selectedEntry: $selectedEntry)
        }
    }
}

#Preview {
    UIKitPokedexView()
}
