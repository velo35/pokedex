//
//  SideMenuView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/24/24.
//

import SwiftUI

struct SideMenuView<Main: View, Side: View>: View
{
    @State private var reveal = false
    let amount = 140.0
    
    let main: Main
    let side: Side
    
    var body: some View
    {
//        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                side
                    .frame(width: amount)
                    .safeAreaPadding(.top, 150)
                
                main
//                    .alignmentGuide(.leading) { d in
//                        d[.leading] + (reveal ? -amount : 0)
//                    }
                    .offset(x: reveal ? amount : 0)
                    .animation(.default, value: reveal)
                
                Button {
                    reveal.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                        .foregroundStyle(.black)
                        .padding(12)
                        .background {
                            Circle()
                                .fill(.gray.opacity(0.6))
                                .stroke(.gray.opacity(0.8), lineWidth: 2)
                        }
                }
//                .ignoresSafeArea()
//                .safeAreaPadding(20)
                .padding(.leading, 6)
//                .padding(.top, -10)
                .safeAreaPadding(.top, 50)
            }
//        }
        .ignoresSafeArea()
//        .background(.yellow)
    }
}

#Preview {
    SideMenuView(main: Color.red, side: Color.blue)
}
