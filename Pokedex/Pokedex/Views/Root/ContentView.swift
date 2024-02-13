//
//  ContentView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

enum UIMode: String, CaseIterable, Identifiable
{
    case swiftUI = "SwiftUI"
    case uiKit = "UIKit"
    
    var id: Self { self }
}

struct ContentView: View 
{
    @AppStorage("ui_mode") private var uiMode = UIMode.swiftUI.rawValue
    
    var body: some View
    {
        SideMenuView(
            main: NavigationStack {
                Group {
                    if uiMode == "SwiftUI" {
                        PokedexView()
                    }
                    else {
                        PokedexViewControllerView()
                    }
                }
                .navigationTitle("Pokemon")
            },
            side: OptionsView(
                mode: Binding {
                    UIMode(rawValue: uiMode)!
                } set: {
                    uiMode = $0.rawValue
                })
        )
    }
}

#Preview {
    ContentView()
}
