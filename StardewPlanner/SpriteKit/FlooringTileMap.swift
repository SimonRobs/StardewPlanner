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
    
    func clearFlooringTile(at coords: GridCoordinate) {
        setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    func setFlooringTile(toTileSet tileSet: TileSets?, at location: CGPoint, ignoringPreviousTile: Bool = true) {
        guard let targetTile = background.getTile(at: location) else { return }
        
        if !ignoringPreviousTile && targetTile == previousTile || !targetTile.buildable { return }
        if ignoringPreviousTile && !targetTile.buildable { return }
        previousTile = targetTile
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet?.rawValue})
        setTileGroup(tileGroup, forColumn: targetTile.i, row: BackgroundRows - 1 - targetTile.j)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }

}
