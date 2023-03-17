//
//  SKSpriteNodeAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

extension SKSpriteNode {
    func showDebugBoundingBox() {
        let bbox = SKShapeNode(rectOf: size)
        bbox.strokeColor = .red
        addChild(bbox)
        
        let textureBBox = SKShapeNode(rectOf: texture?.size() ?? CGSize.zero)
        textureBBox.strokeColor = .cyan
        addChild(textureBBox)
    }
    
    func showDebugAnchorPoint() {
        let anchor = SKShapeNode(circleOfRadius: 2)
        anchor.fillColor = .red
        addChild(anchor)
    }
}
