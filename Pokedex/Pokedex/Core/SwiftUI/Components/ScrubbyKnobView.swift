//
//  ScrubbyKnobView.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/7/24.
//

import SwiftUI

struct ScrubbyKnobView: View 
{
    var body: some View
    {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color(.systemGray4))
                .stroke(.black, lineWidth: 2)
            
            ZStack {
                Circle()
                    .fill(.gray)
                    
                Circle()
                    .fill(Color(.systemGray4))
                    .stroke(.black, lineWidth: 0.5)
                    .offset(x: 2, y: 2)
                
                Circle()
                    .stroke(.black, lineWidth: 2)
            }
            .clipShape(Circle())
            .padding(6)
        }
        .frame(width: 100, height: 40)
    }
}

#Preview {
    ScrubbyKnobView()
        .scaleEffect(3)
}
