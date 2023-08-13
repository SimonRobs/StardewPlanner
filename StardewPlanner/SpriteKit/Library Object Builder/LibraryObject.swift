//
//  LibraryObject.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class LibraryObject: ScenePlaceable {
    
    public enum Tint {
        case Red, Green, Clear
    }
    
    public static let PlacementTileName = "LibraryObject::PlacementTileSprite"
    
    private(set) var sprite: SKSpriteNode
    
    private(set) var type: ObjectTypes
    
    private(set) var sizeInGrid: LibraryObjectSize
    
    private let TintColorBlendFactor = 0.8
    
    private var occupiedTiles: [LibraryObjectPlacementTileSprite] = []
    
    var hasEvenWidth: Bool {
        return sizeInGrid.columns.isMultiple(of: 2)
    }
    
    var hasEvenHeight: Bool {
        return (sizeInGrid.rows + sizeInGrid.verticalOverflow).isMultiple(of: 2)
    }
    
    var hasEvenOverflow: Bool {
        return sizeInGrid.verticalOverflow.isMultiple(of: 2)
    }
    
    init(ofType type: ObjectTypes, withSize size: LibraryObjectSize) {
        self.type = type
        sizeInGrid = size
        let objectTexture = SKTexture(imageNamed: type.rawValue)
        objectTexture.filteringMode = .nearest
        sprite = SKSpriteNode(texture: objectTexture, color: .clear, size: size.toSceneSize())
        populateOccupiedTiles()
        sprite.colorBlendFactor = TintColorBlendFactor
    }
    
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)]) {
        //        for (subsprite, offset) in subsprites {
        //            subsprite.position = CGPoint(x: offset.x * TileSize, y: offset.y * TileSize)
        //            subsprite.zPosition = offset.z
        //            addChild(subsprite)
        //        }
    }
    
    // TODO: This functionality should be deferred to the LibraryObjectPlacer,
    // TODO: so as to take into account other properties like subsprites and area range.
    // TODO: Or, provide a 'center' attribute which is modified by the decorators and used by the placer
    func setPosition(_ newPosition: CGPoint) {
        sprite.position = newPosition
        // Move the sprite to its top-left tile, like in Stardew Valley
        sprite.position.x += sprite.size.width / 2 - TileSize / 2
        sprite.position.y += sprite.size.height / 2 - TileSize / 2
        sprite.position.y -= CGFloat(sizeInGrid.rows - 1) * TileSize
        sprite.zPosition = CGFloat(sprite.position.toGridCoordinate().j)
        
        recalculateOccupiedTilesPositions()
    }
    
    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite] {
        return occupiedTiles
    }
    
    func showOccupiedTiles() {
        sprite.color = .clear
        sprite.colorBlendFactor = 1
        occupiedTiles.forEach { tile in tile.alpha = 1}
    }
    
    func hideOccupiedTiles() {
        sprite.colorBlendFactor = 0
        sprite.removeAllChildren()
    }
    
    func containsUnbuildableTiles() -> Bool {
        for tile in occupiedTiles {
            if !tile.isBuidable() {
                return true
            }
        }
        return false
    }
    
    func setTint(_ tint: LibraryObject.Tint) {
        changeTint(of: sprite, to: tint)
        setSubspritesTint(to: tint)
    }
    
    private func recalculateOccupiedTilesPositions() {
        for column in 0..<sizeInGrid.columns {
            for row in 0..<sizeInGrid.rows {
                let tile = occupiedTiles[column * sizeInGrid.rows + row]
                tile.updateCoordinates(to: getChildTileCoordinates(column, row))
            }
        }
    }
    
    private func setSubspritesTint(to tint: LibraryObject.Tint) {
        guard let subsprites = sprite.children as? [SKSpriteNode] else { return }
        subsprites
            .filter { subsprite in subsprite.name != ObjectPlacementTileName }
            .forEach { subsprite in changeTint(of: subsprite, to: tint) }
    }
    
    private func changeTint(of node: SKSpriteNode, to tint: LibraryObject.Tint) {
        if tint == .Clear { node.colorBlendFactor = 0 }
        else {
            node.colorBlendFactor = TintColorBlendFactor
            node.color = tint == .Green ? .green : .red
        }
    }
    
    private func populateOccupiedTiles() {
        for column in 0..<sizeInGrid.columns {
            for row in 0..<sizeInGrid.rows {
                let tile = LibraryObjectPlacementTileSprite(
                    at: getChildTileCoordinates(column, row)
                )
                tile.alpha = 0
                sprite.addChild(tile)
                tile.position.x += (hasEvenWidth ? 0 : TileSize / 2)
                tile.position.y += (hasEvenHeight ? TileSize / 2 : 0)
                occupiedTiles.append(tile)
            }
        }
    }
    
    private func getChildTileCoordinates(_ column: Int, _ row: Int) -> GridCoordinate {
        let center = sprite.position.toGridCoordinate()
        let columnOffset = hasEvenWidth ? 1 : 0
        // Place the tiles at the bottom of the sprite
        return  GridCoordinate(
            i: center.i - sizeInGrid.columns / 2 + columnOffset + column,
            j: center.j - sizeInGrid.rows + row + (sizeInGrid.rows + sizeInGrid.verticalOverflow) / 2 + 1
        )
    }
}
