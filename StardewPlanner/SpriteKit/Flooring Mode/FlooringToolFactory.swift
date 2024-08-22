//
//  FlooringToolFactory.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SpriteKit

class FlooringToolFactory {
    
    static func createTool(ofType type: FlooringTools) -> FlooringToolBase {
        switch type {
        case .FreeDraw:
            return FreeDrawTool()
        case .Eraser:
            return EraserTool()
        case .Bucket:
            return BucketTool()
        case .Eyedropper:
            return EyedropperTool()
        case .Shape:
            return ShapeTool()
        case .Line:
            return LineTool()
        }
    }
}
