//
//  ContentView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct ContentView: View 
{
    @Environment(\.colorScheme) var colorScheme
    
    @State private var uiMode = UIMode.swiftUI
    
    var body: some View
    {
        NavigationStack {
            SideMenuView {
                Group {
                    if uiMode == .swiftUI {
                        SwiftPokedexView()
                    }
                    else {
                        UIKitPokedexView()
                    }
                }
                .background(colorScheme == .light ? Color.white : Color.black)
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
