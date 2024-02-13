//
//  OptionsPanel.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct OptionsPanel: View 
{
    @Binding var mode: UIMode
    
    var body: some View
    {
        VStack(spacing: 16) {
            ForEach(UIMode.allCases) { uiMode in
                Button(uiMode.rawValue) {
                    mode = uiMode
                }
            }
        }
    }
}

#Preview {
    OptionsPanel(mode: .constant(UIMode.swiftUI))
}
