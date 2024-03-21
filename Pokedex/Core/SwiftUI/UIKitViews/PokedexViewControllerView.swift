//
//  ViewControllerView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/26/24.
//

import SwiftUI

struct PokedexViewControllerView: UIViewControllerRepresentable
{
    let selectedCallback: (PokemonEntry) -> Void
    
    func makeUIViewController(context: Context) -> PokedexViewController
    {
        PokedexViewController(selectedCallback: selectedCallback)
    }
    
    func updateUIViewController(_ uiViewController: PokedexViewController, context: Context) 
    {
        
    }
}

#Preview {
    PokedexViewControllerView() { _ in
        
    }
}
