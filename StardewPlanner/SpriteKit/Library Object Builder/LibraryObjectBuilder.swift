//
//  LibraryObjectBuilder.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectBuilder {
    
    static func buildObject(from definition: LibraryObjectDef, overlayTileMap: RangeOverlayTileMap) -> ScenePlaceable? {
        // TODO: Determine sprite size extension
        guard let objectSize = definition.metadata?.size else { return nil }
        let object = LibraryObject(ofType: definition.type, withSize: objectSize)
        
        if let area = definition.metadata?.area {
            object.addModifier(ofType: .Ranged, RangedModifier(object, area: area, overlayTileMap: overlayTileMap))
        }
        
        if definition.metadata?.hasBuildingShadow != nil {
            object.addModifier(ofType: .Shadowed, ShadowedModifier(object))
        }
        
        return object
    }
    
    //    private static func getSubsprites(from subtextures: [LibraryObjectSubtexture]) -> [(SKSpriteNode, CGPoint3D)] {
    //        var subsprites: [(SKSpriteNode, CGPoint3D)] = []
    //        for subtexture in subtextures {
    //            var subsprite: SKSpriteNode
    //            if let animationFrames = subtexture.animationFrames {
    //                var animation: [SKTexture] = []
    //                subsprite = SKSpriteNode(imageNamed: "\(subtexture.name) 0")
    //                for frameIndex in 1..<animationFrames {
    //                    let texture = SKTexture(imageNamed: "\(subtexture.name) \(frameIndex)")
    //                    texture.filteringMode = .nearest
    //                    animation.append(texture)
    //                }
    //                subsprite.run(SKAction.repeatForever(SKAction.animate(with: animation, timePerFrame: TimeInterval(1.0 / Double(AnimationsFPS)))))
    //            } else {
    //                subsprite = SKSpriteNode(imageNamed: subtexture.name)
    //            }
    //            subsprite.texture?.filteringMode = .nearest
    //            subsprites.append((subsprite, subtexture.offset))
    //        }
    //        return subsprites
    //    }
}
