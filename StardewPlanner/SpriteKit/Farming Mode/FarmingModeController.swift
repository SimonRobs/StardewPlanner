//
//  FarmingModeController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import SpriteKit

public class FarmingModeController: Controller, LibraryObjectHandler {
    
    private let tileMap: FlooringTileMap
    private let objectPlacer: LibraryObjectPlacer
    private let tilledDirtTileSet: SKTileSet
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.tileMap = tileMap
        tilledDirtTileSet = TileSetController.MakeTileSet(from: TilledDirtTileSets.allCases.map({$0.rawValue}))
        objectPlacer = LibraryObjectPlacer(in: scene, tileMap: tileMap)
    }
    
    func activate() {
        objectPlacer.activate()
    }
    
    func deactivate() {
        objectPlacer.deactivate()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        objectPlacer.mouseEntered(with: event)
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        objectPlacer.mouseExited(with: event)
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        objectPlacer.mouseMoved(with: event)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        objectPlacer.mouseDown(with: event)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        objectPlacer.mouseUp(with: event)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        objectPlacer.mouseDragged(with: event)
    }
    
    func setObject(from definition: LibraryObjectDef) {
        objectPlacer.setObject(from: definition)
    }
    
    func cleanUp() {
        objectPlacer.cleanUp()
    }
}
