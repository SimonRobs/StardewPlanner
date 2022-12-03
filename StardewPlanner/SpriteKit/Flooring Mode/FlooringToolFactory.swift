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
        default:
            fatalError("Tool Not Implemented")
        }
    }
}
