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
    
    init(at coords: GridCoordinate) {
        super.init(texture: SKTexture(imageNamed: "Green Tile"), color:.clear, size: CGSize(width: TileSize, height: TileSize))
        position = coords.toLocation()
        
//        let label = SKLabelNode(text: "\(coords.i) \(coords.j)")
//        addChild(label)
    }

    func isBuidable() ->Bool {
        return buildable
    }
    
    func setBuildable(_ buildable: Bool) {
        self.buildable = buildable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
}
