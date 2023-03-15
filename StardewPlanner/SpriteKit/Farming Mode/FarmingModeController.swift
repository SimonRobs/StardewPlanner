//
//  FarmingModeController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import SpriteKit

public class FarmingModeController: Controller, ObjectPlacer {
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    var selectedObject: LibraryObject?
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
    }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) { }
    
    func mouseDown(with event: TileMapMouseEvent) { }
    
    func mouseUp(with event: TileMapMouseEvent) { }
    
    func mouseDragged(with event: TileMapMouseEvent) { }
    
    func setObject(_ object: LibraryObject) { }
}
