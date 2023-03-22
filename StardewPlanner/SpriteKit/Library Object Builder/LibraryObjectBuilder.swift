//
//  LibraryObjectBuilder.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectBuilder {
    
    static func buildObject(_ object: LibraryObject) -> LibraryObjectSprite? {
        // TODO: Determine sprite size extension
        
        let objectTexture = SKTexture(imageNamed: object.type.rawValue)
        objectTexture.filteringMode = .nearest
        let objectSprite = LibraryObjectSprite(
            objectType: object.type,
            objectSize: object.metadata?.size ?? LibraryObjectSize.zero,
            texture: objectTexture
        )
        
        if let subtextures = object.metadata?.subtextures {
            let subsprites = getSubsprites(from: subtextures)
            objectSprite.setSubsprites(subsprites: subsprites)
        }
        
        if object.metadata?.hasBuildingShadow == true { objectSprite.drawBuildingShadow() }
        if let seasonal = object.metadata?.seasonal { objectSprite.setSeasonalStatus(isSeasonal: seasonal) }
        if let variant = object.metadata?.variant { objectSprite.setVariant(variant: variant) }
        if let inWaterOnly = object.metadata?.inWaterOnly { objectSprite.isOnlyPlaceableInWater(inWaterOnly: inWaterOnly) }
        if let objectArea = object.metadata?.area { objectSprite.setArea(to: objectArea) }
        
        return objectSprite
    }
    
    private static func getSubsprites(from subtextures: [LibraryObjectSubtexture]) -> [(SKSpriteNode, CGPoint3D)] {
        var subsprites: [(SKSpriteNode, CGPoint3D)] = []
        for subtexture in subtextures {
            var subsprite: SKSpriteNode
            if let animationFrames = subtexture.animationFrames {
                var animation: [SKTexture] = []
                subsprite = SKSpriteNode(imageNamed: "\(subtexture.name) 0")
                for frameIndex in 1..<animationFrames {
                    let texture = SKTexture(imageNamed: "\(subtexture.name) \(frameIndex)")
                    texture.filteringMode = .nearest
                    animation.append(texture)
                }
                subsprite.run(SKAction.repeatForever(SKAction.animate(with: animation, timePerFrame: TimeInterval(1.0 / Double(AnimationsFPS)))))
            } else {
                subsprite = SKSpriteNode(imageNamed: subtexture.name)
            }
            subsprite.texture?.filteringMode = .nearest
            subsprites.append((subsprite, subtexture.offset))
        }
        return subsprites
    }
}
