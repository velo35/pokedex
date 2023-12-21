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
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 36)
            .offset(y: typeFiltersShown ? 0 : 190)
            .clipped()
        }
        .overlay(alignment: .bottom) {
            Image(systemName: typeFilter == nil ? "line.3.horizontal.decrease.circle.fill" : "arrow.counterclockwise.circle.fill")
                .renderingMode(.original)
                .font(.system(size: 45))
                .foregroundStyle(.purple)
                .shadow(color: .black, radius: 5)
                .rotationEffect(.degrees(typeFilter == nil && typeFiltersShown ? 180 : 0))
                .animation(typeFilter == nil ? .default : nil, value: typeFiltersShown)
                .offset(y: 22)
                .onTapGesture {
                    withAnimation {
                        typeFiltersShown.toggle()
                    }
                }
        }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}

#Preview {
    StatefulPreviewWrapper(nil) { TypeFilterView(typeFilter: $0) }
}
