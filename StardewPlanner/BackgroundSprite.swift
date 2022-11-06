//
//  BackgroundSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class BackgroundSprite: SKSpriteNode {
    
    init() {
        super.init(texture: SKTexture(imageNamed: "full_background_spring"), color:.clear, size: CGSize(width: 1280, height: 1040))
        
        name = BackgroundSpriteName
        
        for i in 0..<BackgroundColumns {
            for j in 0..<BackgroundRows {
                let t = BackgroundTile(i: i, j: j, buildable: BackgroundBuildableTiles[i][j])
                t.position.x = -frame.size.width / 2 + TileSize * CGFloat(i) + TileSize / 2
                t.position.y = frame.size.height / 2 - TileSize * CGFloat(j) - TileSize / 2
                addChild(t)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
}
