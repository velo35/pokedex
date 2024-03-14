//
//  SideMenuView.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/24/24.
//

import SwiftUI

struct SideMenuView<MainContent: View, SideContent: View>: View
{
    @State private var reveal = false
    private let amount = 180.0
    
    @ViewBuilder let main: () -> MainContent
    @ViewBuilder let side: () -> SideContent
    
    var body: some View
    {
        ZStack(alignment: .leading) {
            side()
                .frame(width: amount)
                .safeAreaPadding(.top, 150)
            
            main()
                .offset(x: reveal ? amount : 0)
                .animation(.default, value: reveal)
                .gesture(
                    LongPressGesture(minimumDuration: 0.1).onEnded { _ in
                        reveal = false
                    },
                    including: reveal ? .gesture : .subviews
                )
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    reveal.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(12)
                        .background {
                            Circle()
                                .fill(.gray.opacity(0.6))
                                .stroke(.gray.opacity(0.8), lineWidth: 2)
                        }
                }
            }
        }
    }
}

#Preview {
    SideMenuView {
        Color.red
    } side: {
        Color.blue
    }
}
