//
//  FlooringModeController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-01.
//

import SpriteKit

public class FlooringModeController {
    
    private var tools: [FlooringTools: FlooringToolBase] = [:]
    private var selectedTool: FlooringToolBase?
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        NotificationController.instance.subscribe(observer: self, name: .onFlooringModeToolChanged, callbackSelector: #selector(handleToolSelected), object: nil)
        
        setSelectedTool(ofType: .FreeDraw)
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        selectedTool?.mouseEntered(with: event)
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        selectedTool?.mouseExited(with: event)
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        selectedTool?.mouseMoved(with: event)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        selectedTool?.mouseDown(with: event)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        selectedTool?.mouseUp(with: event)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        selectedTool?.mouseDragged(with: event)
    }
    
    @objc private func handleToolSelected(_ notification: Notification) {
        guard let type = notification.object as? FlooringTools else { return }
        setSelectedTool(ofType: type)
    }
    
    private func setSelectedTool(ofType type: FlooringTools) {
        if selectedTool?.type == type { return }
        if tools[type] == nil {
            tools[type] = FlooringToolFactory.createTool(ofType: type, in: scene, tileMap: tileMap)
        }
        selectedTool?.deactivate()
        selectedTool = tools[type]!
        selectedTool?.activate()
    }
    
}
