//
//  EraserTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class EraserTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Eraser } }
    
    private var drawOptions = EraserToolOptions()
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    private var eraserSize: CGFloat {
        get {
            return drawOptions.size
        }
    }
    
    private var eraserShape: BrushShapes {
        get {
            return drawOptions.shape
        }
    }
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        subscribe()
    }
    
    func activate() {
        tileMap.overlay.alpha = 1
    }
    
    func deactivate() {
        tileMap.overlay.alpha = FlooringTileMapOverlay.DefaultAlpha
        tileMap.overlay.clear()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        moveOverlay(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        eraseTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        moveOverlay(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        moveOverlay(to: event.location)
        eraseTiles(at: event.location) 
    }
    
    private func moveOverlay(to location: CGPoint) {
        tileMap.overlay.clear()
        tileMap.overlay.enableAutomapping = false
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: eraserShape,
                                                            ofSize: eraserSize,
                                                            centerAt: location.toGridCoordinate())
        {
            tileMap.overlay.setFlooringTile(toTileSet: .Eraser, at: gridCoord)
        }
        tileMap.overlay.enableAutomapping = true
    }
    
    private func eraseTiles(at location: CGPoint) {
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: eraserShape,
                                                            ofSize: eraserSize,
                                                            centerAt: location.toGridCoordinate())
        {
            tileMap.clearFlooringTile(at: gridCoord)
        }
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? EraserToolOptions else { return }
        drawOptions = options
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onEraserToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
