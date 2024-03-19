//
//  ViewControllerView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/26/24.
//

import SwiftUI

struct PokedexViewControllerView: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> PokedexViewController
    {
        PokedexViewController()
    }
    
    func updateUIViewController(_ uiViewController: PokedexViewController, context: Context) 
    {
        
    }
}

#Preview {
    PokedexViewControllerView()
}
