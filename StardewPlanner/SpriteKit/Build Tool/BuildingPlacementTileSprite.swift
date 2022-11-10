//
//  BuildingPlacementTileSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-10.
//

import SpriteKit

class BuildingPlacementTileSprite: SKSpriteNode {
    
    private var buildable = true {
        didSet {
            texture = SKTexture(imageNamed: buildable ? "Green Tile" : "Red Tile")
        }
    }
    
    init(at positionInGrid: CGPoint, verticalOverflow: Int, buildingSize: CGSize) {
        super.init(texture: SKTexture(imageNamed: "Green Tile"), color:.clear, size: CGSize(width: TileSize, height: TileSize))
        position.x = TileSize * CGFloat(positionInGrid.x) - buildingSize.width / 2 + TileSize / 2
        position.y = buildingSize.height / 2 - TileSize * CGFloat(positionInGrid.y) - CGFloat(verticalOverflow) * TileSize - TileSize / 2
    }
    
    func verifyStatus() {
        guard let parent = parent else { return }
        let sceneX = parent.position.x + position.x
        let sceneY = parent.position.y + position.y
        let i = Int((sceneX + BackgroundSize.width / 2 - TileSize / 2) / TileSize)
        let j = Int((BackgroundSize.height / 2 - sceneY - TileSize / 2) / TileSize)
        let isBackgroundBuildable = i < 0 || j < 0 || i >= BackgroundColumns || j >= BackgroundRows  ? false : BackgroundBuildableTiles[i][j]
        if buildable && !isBackgroundBuildable {
            buildable = false
        } else if !buildable && isBackgroundBuildable {
            buildable = true
        }
    }
    
    func isBuidable() ->Bool {
        return buildable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
}
