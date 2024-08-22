//
//  FlooringOverlayLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class FlooringOverlayLayer: SKNode, SceneLayer {
    static private let DefaultAlpha = 0.3
    
    private let overlayTileMap: SKTileMapNode
    
    init(with scene: SKScene) {
        overlayTileMap = SKTileMapNode(tileSet: TileSetController.instance.flooringTileSet,
                                       columns: BackgroundColumns,
                                       rows: BackgroundRows,
                                       tileSize: CGSize(width: TileSize, height: TileSize)
        )
        super.init()
        
        overlayTileMap.alpha = FlooringOverlayLayer.DefaultAlpha
        addChild(overlayTileMap)
        
        zPosition = FlooringOverlayLayerZPosition
        scene.addChild(self)
    }
    
    func clear() {
        overlayTileMap.fill(with: nil)
    }
    
    func overrideAlpha(_ alpha: CGFloat) {
        overlayTileMap.alpha = alpha
    }
    
    func resetAlpha() {
        overlayTileMap.alpha = FlooringOverlayLayer.DefaultAlpha
    }
    
    func disableAutomapping() {
        overlayTileMap.enableAutomapping = false
    }
    
    func enableAutomapping() {
        overlayTileMap.enableAutomapping = true
    }
    
    func clearTile(at coords: GridCoordinate) {
        overlayTileMap.setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    func setTile(toTileSet tileSet: TileSets?, at coords: GridCoordinate) {
        setTile(toTileSet: tileSet, forColumn: coords.i, row: coords.j)
    }
    
    func setTile(toTileSet tileSet: CustomTileSets, at coords: GridCoordinate) {
        setTileGroup(tileSetName: tileSet.rawValue, forColumn: coords.i, row: coords.j)
    }
    
    func setTile(toTileSet tileSet: TileSets?, forColumn column: Int, row: Int) {
        if tileSet == .Empty { return }
        setTileGroup(tileSetName: tileSet?.rawValue, forColumn: column, row: row)
    }
    
    func setTile(toTileSet tileSet: TilledDirtTileSets, forColumn column: Int, row: Int) {
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet.rawValue})
        overlayTileMap.setTileGroup(tileGroup, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    private func setTileGroup(tileSetName name: String?, forColumn column: Int, row: Int) {
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        let tileGroup = flooringTileGroups.first(where: {g in g.name == name})
        overlayTileMap.setTileGroup(tileGroup, forColumn: column, row: BackgroundRows - 1 - row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
}
