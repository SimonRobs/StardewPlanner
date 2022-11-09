//
//  BuildingSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import SpriteKit

class BuildingSprite: SKSpriteNode {
    
    private var tileMapSize: BuildingSize
    
    init(_ type: AllBuildings, with size: BuildingSize) {
        tileMapSize = size
        let spriteSize = CGSize(
            width: CGFloat(size.columns) * TileSize,
            height: CGFloat(size.rows) * TileSize + CGFloat(size.verticalOverflow) * TileSize
        )
        super.init(texture: SKTexture(imageNamed: type.rawValue), color:.green, size: spriteSize)
        colorBlendFactor = 0.8
    }
    
    func showOccupiedTiles() {
        color = .clear
        colorBlendFactor = 1
        for i in 0..<tileMapSize.columns {
            for j in 0..<tileMapSize.rows {
                let tile = SKSpriteNode(imageNamed: "Green Tile")
                tile.position.x = TileSize * CGFloat(i) - size.width / 2 + TileSize / 2
                tile.position.y = size.height / 2 - TileSize * CGFloat(j) - CGFloat(tileMapSize.verticalOverflow) * TileSize - TileSize / 2
                addChild(tile)
            }
        }
    }
    
    func hideOccupiedTiles() {
        colorBlendFactor = 0
    }
    
    func removeGreenTint() {
        color = .clear
        colorBlendFactor = 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
}
