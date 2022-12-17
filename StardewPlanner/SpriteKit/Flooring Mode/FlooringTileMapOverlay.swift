//
//  FlooringTileMapOverlay.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-17.
//

import SpriteKit

class FlooringTileMapOverlay: SKTileMapNode {

    override init() {
        super.init(tileSet: TileSetController.instance.flooringTileSet,
                   columns: BackgroundColumns,
                   rows: BackgroundRows,
                   tileSize: CGSize(width: TileSize, height: TileSize)
        )
        alpha = 0.3
    }
    
    func clear() {
        fill(with: nil)
    }
    
    func clearFlooringTile(at coords: GridCoordinate) {
        setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    func setFlooringTile(toTileSet tileSet: TileSets?, at coords: GridCoordinate) {
        setFlooringTile(toTileSet: tileSet, forColumn: coords.i, row: coords.j)
    }
    
    func setFlooringTile(toTileSet tileSet: CustomTileSets, at coords: GridCoordinate) {
        setTileGroup(tileSetName: tileSet.rawValue, forColumn: coords.i, row: coords.j)
    }
    
    func setFlooringTile(toTileSet tileSet: TileSets?, forColumn column: Int, row: Int) {
        if tileSet == .Empty { return }
        setTileGroup(tileSetName: tileSet?.rawValue, forColumn: column, row: row)
    }
    
    private func setTileGroup(tileSetName name: String?, forColumn column: Int, row: Int) {
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == name})
        super.setTileGroup(tileGroup, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override func setTileGroup(_ tileGroup: SKTileGroup, andTileDefinition tileDefinition: SKTileDefinition, forColumn column: Int, row: Int) {
        fatalError("Attempting to call illegal method... Please call setFlooringTile instead")
    }
    
    override func setTileGroup(_ tileGroup: SKTileGroup?, forColumn column: Int, row: Int) {
        fatalError("Attempting to call illegal method... Please call setFlooringTile instead")
    }
    

}
