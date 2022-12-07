//
//  EyedropperTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class EyedropperTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Eyedropper } }
    
    private var drawOptions = EyedropperToolOptions()
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
    }
    
    func activate() { }
    
    func deactivate() { }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) { }
    
    func mouseDown(with event: TileMapMouseEvent) { }
    
    func mouseUp(with event: TileMapMouseEvent) { }
    
    func mouseDragged(with event: TileMapMouseEvent) { }
    
    private func subscribe() { }
    
    private func unsubscribe() { }
}
