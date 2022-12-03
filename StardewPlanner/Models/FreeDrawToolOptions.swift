//
//  FreeDrawToolOptions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import Foundation

struct FreeDrawToolOptions {
    
    enum BrushShapes: String, CaseIterable {
        case Square = "square"
        case Round = "circle"
    }
    
    var size: CGFloat
    var shape: BrushShapes
    
    init() {
        size = 0
        shape = .Square
    }
    
    init(size: CGFloat, shape: BrushShapes) {
        self.size = size
        self.shape = shape
    }
    
}
