//
//  ComposedTextureModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

// Object with multiple sprites as the texture
class ComposedTextureModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
    }
    
    func contains(_ location: CGPoint) -> Bool {
        return false
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
