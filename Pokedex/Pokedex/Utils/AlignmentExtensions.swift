//
//  AlignmentExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 2/12/24.
//

import SwiftUI

extension VerticalAlignment
{
    private struct SelectionAlignment: AlignmentID
    {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let selectionAlignmentGuide = VerticalAlignment(SelectionAlignment.self)
}
