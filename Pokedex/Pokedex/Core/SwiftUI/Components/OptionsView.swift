//
//  OptionsPanel.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/25/24.
//

import SwiftUI

struct OptionsView: View 
{
    @AppStorage("ui_mode") private var uiMode = UIMode.swiftUI
    
    var body: some View
    {
        VStack(spacing: 0) {
            Text("UI Mode")
                .font(.largeTitle)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .selectionAlignmentGuide)) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.purple.opacity(0.5))
                    .frame(width: 120, height: 40)
                    .alignmentGuide(.selectionAlignmentGuide) { d in
                        d[VerticalAlignment.center]
                    }
                    .animation(.easeInOut(duration: 0.25), value: uiMode)
                
                VStack(spacing: 16) {
                    ForEach(UIMode.allCases) { uiMode in
                        Button {
                            self.uiMode = uiMode
                        } label: {
                            Text(uiMode.rawValue)
                                .font(.title.weight(.semibold))
                                .foregroundStyle(.black)
                        }
                        .alignmentGuide(self.uiMode == uiMode ? .selectionAlignmentGuide : VerticalAlignment.center) { d in
                            d[VerticalAlignment.center]
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .preference(key: UIMOdePreferenceKey.self, value: uiMode)
    }
}

#Preview {
    OptionsView()
}
