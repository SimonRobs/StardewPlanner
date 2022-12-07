//
//  EraserToolOptions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import Foundation

struct EraserToolOptions {
    enum BrushShapes: String, CaseIterable {
        case Square = "square"
        case Round = "circle"
    }
    
    static let MinBrushSize: CGFloat = 1
    static let MaxBrushSize: CGFloat = 9
    
    var size: CGFloat
    var shape: BrushShapes
    
    init() {
        size = 1
        shape = .Square
    }
    
    init(size: CGFloat, shape: BrushShapes) {
        self.size = size
        self.shape = shape
    }
}
