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
        VStack {
            Text("UI Mode")
                .font(.largeTitle)
            
            Spacer()
                .frame(height: 20)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .selectionAlignmentGuide)) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.purple.opacity(0.5))
                    .frame(width: 120, height: 40)
                    .alignmentGuide(.selectionAlignmentGuide) { d in
                        d[VerticalAlignment.center]
                    }
                
                
                VStack(spacing: 16) {
                    ForEach(UIMode.allCases) { uiMode in
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                mode = uiMode
                            }
                        } label: {
                            Text(uiMode.rawValue)
                                .font(.title.weight(.semibold))
                                .foregroundStyle(.black)
                        }
                        .alignmentGuide(mode == uiMode ? .selectionAlignmentGuide : VerticalAlignment.center) { d in
                            d[VerticalAlignment.center]
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OptionsPanel(mode: .constant(UIMode.swiftUI))
}
