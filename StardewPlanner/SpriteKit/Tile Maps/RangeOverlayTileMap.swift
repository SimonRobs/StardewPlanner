//
//  RangeOverlayTileMap.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-20.
//

import SpriteKit

class RangeOverlayTileMap: SKTileMapNode {
    
    private var rangeCoordsByType: [ObjectTypes:[GridCoordinate]]
    private var temporaryRangeTiles: [GridCoordinate]
    private var temporaryCenter: GridCoordinate?
    
    override init() {
        rangeCoordsByType = [:]
        temporaryRangeTiles = []
        super.init(tileSet: TileSetController.instance.rangeOverlayTileSet,
                   columns: BackgroundColumns,
                   rows: BackgroundRows,
                   tileSize: CGSize(width: TileSize, height: TileSize)
        )
    }
    
    func hideAll() {
        super.fill(with: nil)
    }
    
    func showAll(ofType type: ObjectTypes) {
        guard let rangeCoords = rangeCoordsByType[type] else { return }
        for coords in rangeCoords {
            setTile(at: coords)
        }
    }
    
    func saveTemporaryRangeTiles(forType type: ObjectTypes) {
        if !rangeCoordsByType.keys.contains(type) {
            rangeCoordsByType[type] = []
        }
        rangeCoordsByType[type]!.append(contentsOf: temporaryRangeTiles)
    }
    
    func setTemporaryRangeTiles(_ tiles: [GridCoordinate], at center: GridCoordinate) {
        temporaryRangeTiles = tiles
        temporaryCenter = center
    }
    
    func clearTemporaryRangeTiles() {
        temporaryRangeTiles.removeAll()
        temporaryCenter = nil
    }
    
    func updateTemporaryRangeTilesCenter(_ center: GridCoordinate) {
        temporaryCenter = center
    }
    
    private func clearTile(at coords: GridCoordinate) {
        super.setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    private func setTile(at coords: GridCoordinate) {
        let tileGroup = TileSetController.instance.rangeOverlayTileSet.tileGroups.first!
        super.setTileGroup(tileGroup, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override func setTileGroup(_ tileGroup: SKTileGroup, andTileDefinition tileDefinition: SKTileDefinition, forColumn column: Int, row: Int) {
        fatalError("Attempting to call illegal method... Please call setTile instead")
    }
    
    override func setTileGroup(_ tileGroup: SKTileGroup?, forColumn column: Int, row: Int) {
        fatalError("Attempting to call illegal method... Please call setTile instead")
    }
    
    
}
