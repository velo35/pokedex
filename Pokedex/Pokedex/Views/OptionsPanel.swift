//
//  OptionsPanel.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct OptionsPanel: View 
{
    @Binding var mode: UIMode?
    
    var body: some View
    {
        List(selection: $mode) {
            ForEach(UIMode.allCases) {
                Text($0.rawValue)
            }
        }
    }
}

#Preview {
    OptionsPanel(mode: .constant(UIMode.swiftUI))
}
