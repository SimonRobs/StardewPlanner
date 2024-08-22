//
//  ShadowedModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class ShadowedModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
        drawShadow()
    }
    
    private func drawShadow() {
        let sprite = object.getSprite()
        let size = object.sizeInGrid.toSceneSize()
        let yOffset = size.height / 2 + TileSize / 2
        let xOffset = size.width / 2 - TileSize / 2
        
        // Left Shadow
        let leftShadow = SKSpriteNode(imageNamed: "Building Shadow Left")
        leftShadow.position.x -= xOffset
        leftShadow.position.y -= yOffset
        sprite.addChild(leftShadow)
        
        // Middle Shadow
        for columnIndex in 1..<(object.sizeInGrid.columns - 1) {
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
