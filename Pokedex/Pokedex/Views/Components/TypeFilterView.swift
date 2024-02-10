//
//  TypeFilterView.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/19/23.
//

import SwiftUI

struct TypeFilterView: View 
{
    @Binding var typeFilter: PokemonType?
    @State private var typeFiltersShown = false
    
    private let typeFilters: [PokemonType] = [.fire, .grass, .water, .electric]
    
    var body: some View
    {
        ZStack {
            VStack {
                VStack(spacing: 6) {
                    ForEach(typeFilters) { type in
                        Button {
                            typeFilter = type
                            withAnimation {
                                typeFiltersShown = false
                            }
                        } label: {
                            type.image
                                .renderingMode(.original)
                                .font(.system(size: 34))
                                .foregroundStyle(type.color)
                                .shadow(color: .black.opacity(1), radius: 4)
                        }
                    }
                }
                .padding()
                .padding(.bottom, 22)
                .offset(y: typeFiltersShown ? 0 : 200)
                .clipped()
            }
            .alignmentGuide(VerticalAlignment.center) { d in
                d[.bottom]
            }
            
            Image(systemName: typeFilter == nil ? "line.3.horizontal.decrease.circle.fill" : "arrow.counterclockwise.circle.fill")
                .renderingMode(.original)
                .font(.system(size: 46))
                .foregroundStyle(.purple)
                .shadow(color: .black, radius: 5)
                .rotationEffect(.degrees(typeFilter == nil && typeFiltersShown ? 180 : 0))
                .animation(typeFilter == nil ? .default : nil, value: typeFiltersShown)
                .onTapGesture {
                    if typeFilter == nil {
                        withAnimation {
                            typeFiltersShown.toggle()
                        }
                    }
                    else {
                        typeFilter = nil
                    }
                }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(nil) { TypeFilterView(typeFilter: $0) }
}
