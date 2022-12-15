//
//  LineToolOptions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import Foundation

struct LineToolOptions {
    
    enum LineCaps: String, CaseIterable {
        case Square = "square"
        case Circle = "circle"
    }
    
    static let MinStrokeWidth: CGFloat = 1
    static let MaxStrokeWidth: CGFloat = 5
    
    var strokeWidth: CGFloat
    var lineCap: LineCaps
    
    init() {
        strokeWidth = 1
        lineCap = .Square
    }
    
    init(strokeWidth: CGFloat, shape: LineCaps) {
        self.strokeWidth = strokeWidth
        self.lineCap = shape
    }
}
