//
//  LibraryObjectSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import SpriteKit

class LibraryObjectSprite: SKSpriteNode {
    
    public enum Tint {
        case Red, Green, Clear
    }
    
    private(set) var type: ObjectTypes
    
    private static let PlacementTileName = "LibraryObjectSprite::PlacementTile"
    
    private let TintColorBlendFactor = 0.8
    
    private var isSeasonal = false //  subscribe to onSeasonChanged, get the current season to begin with
    private var inWaterOnly = false
    private var variant: String? // subscribe to onObjectVariantChanged
    private var area: LibraryObjectArea?
    
    private let sizeInGrid: LibraryObjectSize
    private var occupiedTiles: [LibraryObjectPlacementTileSprite] = []
    
    private var hasEvenWidth: Bool {
        return sizeInGrid.columns.isMultiple(of: 2)
    }
    
    private var hasEvenHeight: Bool {
        return (sizeInGrid.rows + sizeInGrid.verticalOverflow).isMultiple(of: 2)
    }
    
    private var hasEvenOverflow: Bool {
        return sizeInGrid.verticalOverflow.isMultiple(of: 2)
    }
    
    init(objectType: ObjectTypes, objectSize: LibraryObjectSize, texture: SKTexture?) {
        let size = CGSize(
            width: CGFloat(objectSize.columns) * TileSize,
            height: CGFloat(objectSize.rows) * TileSize + CGFloat(objectSize.verticalOverflow) * TileSize
        )
        sizeInGrid = objectSize
        type = objectType
        super.init(texture: texture, color: .clear, size: size)
        populateOccupiedTiles()        
        colorBlendFactor = TintColorBlendFactor
    }
    
    deinit {
        if variant != nil || isSeasonal {
            NotificationController.instance.unsubscribe(observer: self)
        }
    }
    
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)]) {
        for (subsprite, offset) in subsprites {
            subsprite.position = CGPoint(x: offset.x * TileSize, y: offset.y * TileSize)
            subsprite.zPosition = offset.z
            addChild(subsprite)
        }
    }
    
    func setSeasonalStatus(isSeasonal: Bool) {
        self.isSeasonal = isSeasonal
        // TODO: Get active seasonal status and choose the right seasonal texture
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
    }
    
    func isOnlyPlaceableInWater(inWaterOnly: Bool) {
        self.inWaterOnly = inWaterOnly
    }
    
    func setVariant(variant: String) {
        self.variant = variant
        NotificationController.instance.subscribe(observer: self, name: .onObjectVariantChanged, callbackSelector: #selector(handleVariantChanged), object: nil)
    }
    
    func setArea(to area: LibraryObjectArea) {
        self.area = area
        // TODO: Get the shape provider to supply the wanted positions
        var tilePositions: [CGPoint] = []
        if area.shape == .Square {
            for row in -area.radius...area.radius {
                for column in -area.radius...area.radius {
                    tilePositions.append(CGPoint(x: column * Int(TileSize), y: row * Int(TileSize)))
                }
            }
        }
        if area.shape == .Circle {
            for row in -area.radius...area.radius {
                for column in -area.radius...area.radius {
                    let distanceFromCenter = simd_length(simd_quatd(vector: simd_double4(Double(column), Double(row), 0, 0)))
                    let adjustedRadius: Double = Double(area.radius) + 1
                    if distanceFromCenter < adjustedRadius {
                        tilePositions.append(CGPoint(x: column * Int(TileSize), y: row * Int(TileSize)))
                    }
                }
            }
        }
        
        if area.shape == .Kite {
            for row in -area.radius...area.radius {
                for column in -area.radius...area.radius {
                    if abs(column) + abs(row) <= area.radius {
                        tilePositions.append(CGPoint(x: column * Int(TileSize), y: row * Int(TileSize)))
                    }
                }
            }
        }
        
        for position in tilePositions {
            let rangeTile = SKSpriteNode(imageNamed: "Green Tile")
            rangeTile.name = LibraryObjectSprite.PlacementTileName
            rangeTile.position = position
            rangeTile.zPosition = -1
            if hasEvenHeight { rangeTile.position.y -= TileSize / 2 }
            addChild(rangeTile)
        }
        NotificationController.instance.subscribe(observer: self, name: .onShowObjectRangeChanged, callbackSelector: #selector(handleShowRangeChanged), object: nil)
    }
    
    func hideArea() {
        if area == nil { return }
        enumerateChildNodes(withName: LibraryObjectSprite.PlacementTileName, using: { child, _  in
            child.alpha = 0
        })
    }
    
    func showArea() {
        if area == nil { return }
        enumerateChildNodes(withName: LibraryObjectSprite.PlacementTileName, using: { child, _  in
            child.alpha = 1
        })
    }
    
    func drawBuildingShadow() {
        let yOffset = size.height / 2 + TileSize / 2
        let xOffset = size.width / 2 - TileSize / 2
        
        // Left Shadow
        let leftShadow = SKSpriteNode(imageNamed: "Building Shadow Left")
        leftShadow.position.x -= xOffset
        leftShadow.position.y -= yOffset
        addChild(leftShadow)
        
        // Middle Shadow
        for columnIndex in 1..<(sizeInGrid.columns - 1) {
            let middleShadow = SKSpriteNode(imageNamed: "Building Shadow Middle")
            middleShadow.position.y -= yOffset
            middleShadow.position.x += xOffset
            middleShadow.position.x -= TileSize * CGFloat(columnIndex)
            addChild(middleShadow)
        }
        
        // Right Shadow
        let rightShadow = SKSpriteNode(imageNamed: "Building Shadow Right")
        rightShadow.position.x += xOffset
        rightShadow.position.y -= yOffset
        addChild(rightShadow)
    }
    
    func setPosition(_ newPosition: CGPoint) {
        position = newPosition
        // Move the sprite to its top-left tile, like in Stardew Valley
        position.x += size.width / 2 - TileSize / 2
        position.y += size.height / 2 - TileSize / 2
        position.y -= CGFloat(sizeInGrid.rows - 1) * TileSize
        zPosition = CGFloat(position.toGridCoordinate().j)
    }
    
    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite] {
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
    
    func setTint(_ tint: LibraryObjectSprite.Tint) {
        changeTint(of: self, to: tint)
        setSubspritesTint(to: tint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    @objc private func handleVariantChanged(_ notification: Notification) {
        // TODO: Handle changing the object's variant
        //        guard let newVariant = notification.object as? String else { return }
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        // TODO: Handle changing the texture to reflect the new season
        //        guard let newSeason = notification.object as? Seasons else { return }
    }
    
    @objc private func handleShowRangeChanged(_ notification: Notification) {
        // TODO: Handle showing/hiding the range depending on the given value
        //        guard let isRangeShown = notification.object as? Bool else { return }
    }
    
    private func setSubspritesTint(to tint: LibraryObjectSprite.Tint) {
        guard let subsprites = children as? [SKSpriteNode] else { return }
        subsprites
            .filter { subsprite in subsprite.name != ObjectPlacementTileName }
            .forEach { subsprite in changeTint(of: subsprite, to: tint) }
    }
    
    private func changeTint(of node: SKSpriteNode, to tint: LibraryObjectSprite.Tint) {
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
                addChild(tile)
                tile.position.x += (hasEvenWidth ? 0 : TileSize / 2)
                tile.position.y += (hasEvenHeight ? TileSize / 2 : 0)
                occupiedTiles.append(tile)
            }
        }
    }
    
    private func getChildTileCoordinates(_ column: Int, _ row: Int) -> GridCoordinate {
        let center = position.toGridCoordinate()
        let columnOffset = hasEvenWidth ? 1 : 0
        // Place the tiles at the bottom of the sprite
        return  GridCoordinate(
            i: center.i - sizeInGrid.columns / 2 + columnOffset + column,
            j: center.j - sizeInGrid.rows + row + (sizeInGrid.rows + sizeInGrid.verticalOverflow) / 2 + 1
        )
    }
    
}
