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
                if uiMode == "SwiftUI" {
                    PokedexView()
                        .navigationTitle("Pokemon")
                }
                else {
                    PokedexViewControllerView()
                }
            },
            side: OptionsPanel(
                mode: Binding {
                    UIMode(rawValue: uiMode)
                } set: {
                    guard let mode = $0?.rawValue else { return }
                    uiMode = mode
                })
        )
    }
}

#Preview {
    ContentView()
        .environment(PokedexViewModel.shared)
}
