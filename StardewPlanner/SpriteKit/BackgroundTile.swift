//
//  BackgroundTile.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class BackgroundTile: SKSpriteNode {
    let i: Int
    let j: Int
    var buildable = false
    
    init(i: Int, j: Int, buildable: Bool = false) {
        self.i = i
        self.j = j
        self.buildable = buildable
        
        if BUILDING_DEBUG {
            super.init(texture: SKTexture(imageNamed: "\(buildable ? "Green":"Red") Tile"), color: .clear, size: CGSize(width: TileSize, height: TileSize))
        } else {
            super.init(texture: nil, color: .clear, size: CGSize(width: TileSize, height: TileSize))
        }
        
        alpha = 0.4
        name = BackgroundTileName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
}
