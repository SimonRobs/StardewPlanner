//
//  BuildingSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import SpriteKit

class BuildingSprite: SKSpriteNode {
    
    public enum Tint {
        case Red, Green, Clear
    }
    
    private let TintColorBlendFactor = 0.8
    
    private var buildingSize: BuildingSize
    private var occupiedTiles: [BuildingPlacementTileSprite] = []
    
    init(_ type: ObjectTypes, with size: BuildingSize) {
        buildingSize = size
        let spriteSize = CGSize(
            width: CGFloat(size.columns) * TileSize,
            height: CGFloat(size.rows) * TileSize + CGFloat(size.verticalOverflow) * TileSize
        )
        super.init(texture: SKTexture(imageNamed: type.rawValue), color:.green, size: spriteSize)
        populateOccupiedTiles()
        colorBlendFactor = TintColorBlendFactor
    }
    
    func setPosition(to location: CGPoint) {
        position = location
        occupiedTiles.forEach { tile in
            tile.verifyStatus()
        }
    }
    
    func showOccupiedTiles() {
        color = .clear
        colorBlendFactor = 1
        occupiedTiles.forEach { tile in tile.alpha = 1}
    }
    
    func hideOccupiedTiles() {
        colorBlendFactor = 0
        removeAllChildren()
    }
    
    func containsUnbuildableTiles() -> Bool {
        for tile in occupiedTiles {
            if !tile.isBuidable() {
                return true
            }
        }
        return false
    }
    
    func setOccupiedTileStatus(_ tile: SKSpriteNode, buildable: Bool) {
        tile.texture = SKTexture(imageNamed: buildable ? "Green Tile" : "Red Tile")
    }
    
    func setTint(_ tint: BuildingSprite.Tint) {
        if tint == .Clear { colorBlendFactor = 0}
        else {
            colorBlendFactor = TintColorBlendFactor
            color = tint == .Green ? .green : .red
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    private func populateOccupiedTiles() {
        for i in 0..<buildingSize.columns {
            for j in 0..<buildingSize.rows {
                let tile = BuildingPlacementTileSprite(at: CGPoint(x: i, y: j), verticalOverflow: buildingSize.verticalOverflow, buildingSize: size)
                tile.alpha = 0
                addChild(tile)
                occupiedTiles.append(tile)
            }
        }
    }
    
}
