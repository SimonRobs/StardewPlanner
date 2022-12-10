//
//  ShapeToolOptions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import Foundation

struct ShapeToolOptions {
    enum Shapes: String, CaseIterable {
        case Square = "square"
        case Circle = "circle"
    }
    
    static let MinStrokeWidth: CGFloat = 1
    static let MaxStrokeWidth: CGFloat = 5
    
    var strokeWidth: CGFloat
    var shape: Shapes
    
    init() {
        strokeWidth = 1
        shape = .Square
    }
    
    init(strokeWidth: CGFloat, shape: Shapes) {
        self.strokeWidth = strokeWidth
        self.shape = shape
    }
}
