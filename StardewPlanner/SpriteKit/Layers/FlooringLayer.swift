//
//  FlooringLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class FlooringLayer: SKNode, SceneLayer {
    
    private let flooringTileMap: SKTileMapNode
    private var previousTile: BackgroundTile? = nil
    
    init(with scene: SKScene) {
        flooringTileMap = SKTileMapNode(tileSet: TileSetController.instance.flooringTileSet,
                                        columns: BackgroundColumns,
                                        rows: BackgroundRows,
                                        tileSize: CGSize(width: TileSize, height: TileSize)
        )
        super.init()
        zPosition = FlooringLayerZPosition
        addChild(flooringTileMap)
        scene.addChild(self)
    }
    
    func getTileSet(atColumn column: Int, row: Int) -> TileSets? {
        if let groupName = flooringTileMap.tileGroup(atColumn: column, row: BackgroundRows - 1 - row)?.name {
            return TileSets(rawValue:groupName)
        } else {
            return nil
        }
    }
    
    func clearTile(at coords: GridCoordinate) {
        flooringTileMap.setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    func clearTile(atColumn column: Int, row: Int) {
        flooringTileMap.setTileGroup(nil, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    func setTile(toTileSet tileSet: TilledDirtTileSets, forColumn column: Int, row: Int) {
        // Do not forget to make sure that the tile is buildable and unoccupied!
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet.rawValue})
        flooringTileMap.setTileGroup(tileGroup, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    func setTile(toTileSet tileSet: TileSets?, forColumn column: Int, row: Int) {
        // Do not forget to make sure that the tile is buildable and unoccupied!
        if tileSet == .Empty { return }
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet?.rawValue})
        flooringTileMap.setTileGroup(tileGroup, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

