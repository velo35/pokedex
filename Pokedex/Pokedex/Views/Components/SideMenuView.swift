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
    private let amount = 180.0
    
    let main: Main
    let side: Side
    
    var body: some View
    {
        ZStack(alignment: .leading) {
            side
                .frame(width: amount)
                .safeAreaPadding(.top, 150)
            
            ZStack(alignment: .topLeading) {
                main
                
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
                .padding(.leading, 6)
                .safeAreaPadding(.top, 20)
            }
            .offset(x: reveal ? amount : 0)
            .animation(.default, value: reveal)
            .gesture(LongPressGesture(minimumDuration: 0.1).onEnded{ _ in reveal = false }, including: reveal ? .gesture : .subviews)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SideMenuView(main: Color.red, side: Color.blue)
}
