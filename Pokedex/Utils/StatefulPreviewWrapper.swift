//
//  StatefulPreviewWrapper.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/30/23.
//

import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View 
{
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

