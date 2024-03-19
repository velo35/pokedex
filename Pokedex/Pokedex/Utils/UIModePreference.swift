//
//  UIModePreference.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/18/24.
//

import SwiftUI

enum UIMode: String, CaseIterable, Identifiable
{
    case swiftUI = "SwiftUI"
    case uiKit = "UIKit"
    
    var id: Self { self }
}

struct UIMOdePreferenceKey: PreferenceKey
{
    static var defaultValue = UIMode.swiftUI
    
    static func reduce(value: inout UIMode, nextValue: () -> UIMode) {}
}
