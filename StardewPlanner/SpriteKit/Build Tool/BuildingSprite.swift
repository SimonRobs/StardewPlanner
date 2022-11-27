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
    
    private var evenHeight = false
    private var evenWidth = false
    private var buildingSize: BuildingSize
    private var occupiedTiles: [BuildingPlacementTileSprite] = []
    
    init(_ type: ObjectTypes, with size: BuildingSize) {
        buildingSize = size
        if (size.rows + size.verticalOverflow).isMultiple(of: 2) { evenHeight = true }
        if size.columns.isMultiple(of: 2) { evenWidth = true }
        let spriteSize = CGSize(
            width: CGFloat(size.columns) * TileSize,
            height: CGFloat(size.rows) * TileSize + CGFloat(size.verticalOverflow) * TileSize
        )
        super.init(texture: SKTexture(imageNamed: type.rawValue), color:.green, size: spriteSize)
        populateOccupiedTiles()
        colorBlendFactor = TintColorBlendFactor
    }
    
    func setPosition(_ position: CGPoint) {
        self.position = position
        self.position = position.add(
            CGPoint(
                x: evenWidth ? TileSize / 2 : 0,
                y: evenHeight ? TileSize / 2 : TileSize
            )
        )
        zPosition = CGFloat(position.toGridCoordinate().j)
    }
    
    func getOccupiedTiles() -> [BuildingPlacementTileSprite] {
        return occupiedTiles
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
                let tile = BuildingPlacementTileSprite(
                    at: getChildTileCoordinates(i, j)
                )
                tile.alpha = 0
                addChild(tile)
                tile.position = tile.position.add(
                    CGPoint(
                        x: evenWidth ? TileSize : TileSize / 2,
                        y: evenHeight ? TileSize: TileSize * 1.5
                    )
                )
                occupiedTiles.append(tile)
            }
        }
    }
    
    private func getChildTileCoordinates(_ i: Int, _ j: Int) -> GridCoordinate {
        let center = position.toGridCoordinate()
        return  GridCoordinate(
            i: center.i - buildingSize.columns / 2 + i,
            j: center.j + buildingSize.rows / 2 - j + buildingSize.verticalOverflow
        )
    }
    
}
