////
////  LibraryCropSprite.swift
////  StardewPlanner
////
////  Created by Simon Robatto on 2023-03-22.
////
//
//import SpriteKit
//
//class LibraryCropSprite: SKSpriteNode {
//    
//    private(set) var type: ObjectTypes
//    
//    private var isSeasonal = false //  subscribe to onSeasonChanged, get the current season to begin with
//    private var inWaterOnly = false
//    private var variant: String? // subscribe to onObjectVariantChanged
//    private var area: LibraryObjectArea?
//    
//    private let sizeInGrid: LibraryObjectSize
//    private var occupiedTiles: [LibraryObjectPlacementTileSprite] = []
//    
//    private var hasEvenWidth: Bool {
//        return sizeInGrid.columns.isMultiple(of: 2)
//    }
//    
//    private var hasEvenHeight: Bool {
//        return (sizeInGrid.rows + sizeInGrid.verticalOverflow).isMultiple(of: 2)
//    }
//    
//    private var hasEvenOverflow: Bool {
//        return sizeInGrid.verticalOverflow.isMultiple(of: 2)
//    }
//    
//    init(from crop: LibraryObject) {
//        let cropSize = crop.metadata?.size ?? LibraryObjectSize.zero
//        let size = CGSize(
//            width: CGFloat(cropSize.columns) * TileSize,
//            height: CGFloat(cropSize.rows) * TileSize + CGFloat(cropSize.verticalOverflow) * TileSize
//        )
//        sizeInGrid = cropSize
//        self.type = crop.type
//        let texture = SKTexture(imageNamed: crop.type.rawValue)
//        texture.filteringMode = .nearest
//        // TODO: Load tinted texture for flowers if tints != nil
//        super.init(texture: texture, color: .clear, size: size)
//        populateOccupiedTiles()
//    }
//    
//    deinit {
//        if variant != nil || isSeasonal {
//            NotificationController.instance.unsubscribe(observer: self)
//        }
//    }
//    
//    func setPosition(_ newPosition: CGPoint) {
//        position = newPosition
//        // Move the sprite to its top-left tile, like in Stardew Valley
//        position.x += size.width / 2 - TileSize / 2
//        position.y += size.height / 2 - TileSize / 2
//        position.y -= CGFloat(sizeInGrid.rows - 1) * TileSize
//        zPosition = CGFloat(position.toGridCoordinate().j)
//    }
//    
//    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite] {
//        return occupiedTiles
//    }
//    
//    func showOccupiedTiles() {
//        color = .clear
//        colorBlendFactor = 1
//        occupiedTiles.forEach { tile in tile.alpha = 1}
//    }
//    
//    func hideOccupiedTiles() {
//        colorBlendFactor = 0
//        removeAllChildren()
//    }
//    
//    func containsUnbuildableTiles() -> Bool {
//        for tile in occupiedTiles {
//            if !tile.isBuidable() {
//                return true
//            }
//        }
//        return false
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Not Implemented")
//    }
//    
//    @objc private func handleSeasonChanged(_ notification: Notification) {
//        // TODO: Handle changing the texture to reflect the new season
//        //        guard let newSeason = notification.object as? Seasons else { return }
//    }
//    
//    private func populateOccupiedTiles() {
//        for column in 0..<sizeInGrid.columns {
//            for row in 0..<sizeInGrid.rows {
//                let tile = LibraryObjectPlacementTileSprite(
//                    at: getChildTileCoordinates(column, row)
//                )
//                tile.alpha = 0
//                addChild(tile)
//                tile.position.x += (hasEvenWidth ? 0 : TileSize / 2)
//                tile.position.y += (hasEvenHeight ? TileSize / 2 : 0)
//                occupiedTiles.append(tile)
//            }
//        }
//    }
//    
//    private func getChildTileCoordinates(_ column: Int, _ row: Int) -> GridCoordinate {
//        let center = position.toGridCoordinate()
//        let columnOffset = hasEvenWidth ? 1 : 0
//        // Place the tiles at the bottom of the sprite
//        return  GridCoordinate(
//            i: center.i - sizeInGrid.columns / 2 + columnOffset + column,
//            j: center.j - sizeInGrid.rows + row + (sizeInGrid.rows + sizeInGrid.verticalOverflow) / 2 + 1
//        )
//    }
//    
//}
