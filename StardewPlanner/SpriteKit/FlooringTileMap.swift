//
//  FlooringTileMap.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class FlooringTileMap: SKTileMapNode {
    private var background: BackgroundSprite
    
    private var previousTile: BackgroundTile? = nil
    
    init(on background: BackgroundSprite) {
        self.background = background
        super.init(tileSet: TileSetController.instance.flooringTileSet,
                   columns: BackgroundColumns,
                   rows: BackgroundRows,
                   tileSize: CGSize(width: TileSize, height: TileSize)
        )
    }
    
    func isBuildable(atColumn column: Int, row: Int) -> Bool {
        return background.getTile(atColumn: column, row: row)?.buildable ?? false
    }
    
    func getFlooringTileSet(atColumn column: Int, row: Int) -> TileSets? {
        if let groupName = tileGroup(atColumn: column, row: BackgroundRows - 1 - row)?.name {
            return TileSets(rawValue:groupName)
        } else {
            return nil
        }
    }
    
    func clearFlooringTile(at coords: GridCoordinate) {
        setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    func setFlooringTile(toTileSet tileSet: TileSets?, at location: CGPoint, ignoringPreviousTile: Bool = true) {
        if tileSet == .Empty { return }
        
        guard let targetTile = background.getTile(at: location) else { return }
        
        if !ignoringPreviousTile && targetTile == previousTile || !targetTile.buildable { return }
        if ignoringPreviousTile && !targetTile.buildable { return }
        previousTile = targetTile
        
        setFlooringTile(toTileSet: tileSet, forColumn: targetTile.i, row: targetTile.j)
    }
    
    
    func setFlooringTile(toTileSet tileSet: TileSets?, forColumn column: Int, row: Int) {
        if tileSet == .Empty { return }
        if background.getTile(at: GridCoordinate(i: column, j: row))?.buildable == false { return }
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet?.rawValue})
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
