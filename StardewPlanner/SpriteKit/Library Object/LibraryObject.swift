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
    
    private(set) var type: ObjectTypes
    private(set) var sizeInGrid: LibraryObjectSize
    private(set) var modifiers: [ModifierTypes: LibraryObjectModifier]
    
    private let TintColorBlendFactor = 0.8
    
    private var occupiedTiles: [LibraryObjectPlacementTileSprite] = []
    private let rootSprite: SKNode
    private let sprite: SKSpriteNode
    private let cropContainer: SKCropNode
    private let cropMask: SKSpriteNode
    
    var hasEvenWidth: Bool {
        return sizeInGrid.columns.isMultiple(of: 2)
    }
    
    var hasEvenHeight: Bool {
        return (sizeInGrid.rows + sizeInGrid.verticalOverflow).isMultiple(of: 2)
    }
    
    var hasEvenOverflow: Bool {
        return sizeInGrid.verticalOverflow.isMultiple(of: 2)
    }
    
    var hasParent: Bool {
        return rootSprite.parent != nil
    }
    
    init(ofType type: ObjectTypes, withSize size: LibraryObjectSize) {
        self.type = type
        sizeInGrid = size
        let objectTexture = SKTexture(imageNamed: type.rawValue)
        objectTexture.filteringMode = .nearest
        modifiers = [:]
        rootSprite = SKNode()
        sprite = SKSpriteNode(texture: objectTexture, color: .clear, size: size.toSceneSize())
        sprite.colorBlendFactor = TintColorBlendFactor
        cropContainer = SKCropNode()
        cropContainer.addChild(sprite)
        rootSprite.addChild(cropContainer)
        cropMask = SKSpriteNode(color: .red, size: size.toSceneSize(noVerticalOverflow: true))
        cropMask.position.y += cropMask.size.height / 2 - sprite.size.height / 2
        populateOccupiedTiles()
    }
    
    
    func removeFromParent() {
        rootSprite.removeFromParent()
    }
    
    func getSprite() -> SKNode {
        return rootSprite
    }
    
    func getSpriteInternal() -> SKSpriteNode {
        return sprite
    }
    
    func addModifier(ofType type: ModifierTypes, _ modifier: LibraryObjectModifier) {
        modifiers[type] = modifier
    }
    
    func hasModifier(ofType type: ModifierTypes) ->  Bool {
        return modifiers.keys.contains(type)
    }
    
    func getModifier(ofType type: ModifierTypes) -> LibraryObjectModifier? {
        return modifiers[type]
    }
    
    func hideVerticalOverflow() {
        if sizeInGrid.verticalOverflow <= 0 { return }
        cropContainer.maskNode = cropMask
    }
    
    func showVerticalOverflow() {
        if sizeInGrid.verticalOverflow <= 0 { return }
        cropContainer.maskNode = nil
    }
    
    func contains(_ location: CGPoint) -> Bool {
        if rootSprite.contains(location) { return true }
        if hasModifier(ofType: .ComposedTexture) {
            let composedTexModifier = modifiers[.ComposedTexture] as! ComposedTextureModifier
            return composedTexModifier.contains(location)
        }
        return false
    }
    
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)]) {
        //        for (subsprite, offset) in subsprites {
        //            subsprite.position = CGPoint(x: offset.x * TileSize, y: offset.y * TileSize)
        //            subsprite.zPosition = offset.z
        //            addChild(subsprite)
        //        }
    }
    
    func setPosition(_ newPosition: CGPoint) {
        rootSprite.position = newPosition
        // Move the sprite to its top-left tile, like in Stardew Valley
        rootSprite.position.x += sprite.size.width / 2 - TileSize / 2
        rootSprite.position.y += sprite.size.height / 2 - TileSize / 2
        rootSprite.position.y -= CGFloat(sizeInGrid.rows - 1) * TileSize
        rootSprite.zPosition = CGFloat(rootSprite.position.toGridCoordinate().j)
        
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
    
    func cannotBePlaced() -> Bool {
        for tile in occupiedTiles {
            if !tile.isPlaceable() {
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
        let center = rootSprite.position.toGridCoordinate()
        let columnOffset = hasEvenWidth ? 1 : 0
        // Place the tiles at the bottom of the sprite
        return  GridCoordinate(
            i: center.i - sizeInGrid.columns / 2 + columnOffset + column,
            j: center.j - sizeInGrid.rows + row + (sizeInGrid.rows + sizeInGrid.verticalOverflow) / 2 + 1
        )
    }
}
