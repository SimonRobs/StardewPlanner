//
//  FlooringToolFactory.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SpriteKit

class FlooringToolFactory {
    
    static func createTool(ofType type: FlooringTools, in scene: SKScene, tileMap: FlooringTileMap) -> FlooringToolBase {
        switch type {
        case .FreeDraw:
            return FreeDrawTool(in: scene, tileMap: tileMap)
        case .Eraser:
            return EraserTool(in: scene, tileMap: tileMap)
        case .Bucket:
            return BucketTool(in: scene, tileMap: tileMap)
        case .Eyedropper:
            return EyedropperTool(in: scene, tileMap: tileMap)
        case .Shape:
            return ShapeTool(in: scene, tileMap: tileMap)
        case .Line:
            return LineTool(in: scene, tileMap: tileMap)
        }
    }
}
