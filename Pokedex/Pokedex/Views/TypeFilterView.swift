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
    
    var image: some View
    {
        Image(systemName: typeFilter == nil ? "line.3.horizontal.decrease.circle.fill" : "arrow.counterclockwise.circle.fill")
            .renderingMode(.original)
            .font(.system(size: 45))
            .foregroundStyle(.purple)
            .shadow(color: .black, radius: 5)
            .rotationEffect(.degrees(typeFilter == nil && typeFiltersShown ? 180 : 0))
            .animation(typeFilter == nil ? .default : nil, value: typeFiltersShown)
            .padding(.top, 5)
    }
    
    var body: some View
    {
        VStack(alignment: .center) {
            VStack(spacing: 6) {
                ForEach(typeFilters) { type in
                    Button {
                        typeFilter = type
                        print("hi")
                    } label: {
                        type.image
                            .renderingMode(.original)
                            .font(.system(size: 35))
                            .foregroundStyle(type.color)
                            .shadow(color: .black.opacity(0.5), radius: 5)
                    }
                }
            }
            
            
            if typeFilter == nil {
                image
                    .onTapGesture {
                        typeFiltersShown.toggle()
                    }
            }
            else {
                Button {
                    typeFilter = nil
                } label: {
                    image
                }
            }
                
        }
    }
}

#Preview {
    @State var typeFilter: PokemonType?
    return TypeFilterView(typeFilter: $typeFilter)
}
