//
//  ViewControllerView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/26/24.
//

import SwiftUI

struct ViewControllerView: UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> ViewController
    {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) 
    {
        
    }
}

#Preview {
    ViewControllerView()
}
