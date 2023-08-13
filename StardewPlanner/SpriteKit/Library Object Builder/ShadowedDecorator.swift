//
//  ShadowedDecorator.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class ShadowedDecorator: LibraryObjectDecorator {
    
    override init(_ object: ScenePlaceable) {
        super.init(object)
        drawShadow()
    }
    
    private func drawShadow() {
        let yOffset = sprite.size.height / 2 + TileSize / 2
        let xOffset = sprite.size.width / 2 - TileSize / 2
        
        // Left Shadow
        let leftShadow = SKSpriteNode(imageNamed: "Building Shadow Left")
        leftShadow.position.x -= xOffset
        leftShadow.position.y -= yOffset
        sprite.addChild(leftShadow)
        
        // Middle Shadow
        for columnIndex in 1..<(sizeInGrid.columns - 1) {
            let middleShadow = SKSpriteNode(imageNamed: "Building Shadow Middle")
            middleShadow.position.y -= yOffset
            middleShadow.position.x += xOffset
            middleShadow.position.x -= TileSize * CGFloat(columnIndex)
            sprite.addChild(middleShadow)
        }
        
        // Right Shadow
        let rightShadow = SKSpriteNode(imageNamed: "Building Shadow Right")
        rightShadow.position.x += xOffset
        rightShadow.position.y -= yOffset
        sprite.addChild(rightShadow)
    }
}
