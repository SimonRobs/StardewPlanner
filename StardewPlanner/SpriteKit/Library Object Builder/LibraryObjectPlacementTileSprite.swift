//
//  LibraryObjectPlacementTileSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-10.
//

import SpriteKit

class LibraryObjectPlacementTileSprite: SKSpriteNode {
    
    private var buildable = true {
        didSet {
            texture = dynamicTexture
        }
    }
    
    private var dynamicTexture: SKTexture {
        let tex = SKTexture(imageNamed: buildable ? "Green Tile" : "Red Tile")
        tex.filteringMode = .nearest
        return tex
    }
    
    init(at coords: GridCoordinate) {
        super.init(texture: nil, color:.clear, size: CGSize(width: TileSize, height: TileSize))
        position = coords.toLocation()
        texture = dynamicTexture
        name = ObjectPlacementTileName
    }

    func isBuidable() -> Bool {
        return buildable
    }
    
    func setBuildable(_ buildable: Bool) {
        self.buildable = buildable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
}
