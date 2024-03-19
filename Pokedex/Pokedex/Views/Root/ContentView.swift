//
//  ContentView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var uiMode = UIMode.swiftUI
    
    var body: some View
    {
        NavigationStack {
            SideMenuView {
                if uiMode == .swiftUI {
                    PokedexView()
                }
                else {
                    PokedexViewControllerView()
                }
            } side: {
                OptionsView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pokemon")
            .onPreferenceChange(UIMOdePreferenceKey.self) { value in
                uiMode = value
            }
        }
    }
}

#Preview {
    ContentView()
}
