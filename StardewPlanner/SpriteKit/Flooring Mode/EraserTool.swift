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
    
    private let flooringLayer: FlooringLayer
    private let flooringOverlayLayer: FlooringOverlayLayer
    
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
    
    init() {
        flooringLayer = LayersManager.instance.getLayer(ofType: .Flooring) as! FlooringLayer
        flooringOverlayLayer = LayersManager.instance.getLayer(ofType: .FlooringOverlay) as! FlooringOverlayLayer
        
        subscribe()
    }
    
    func activate() {
        flooringOverlayLayer.overrideAlpha(1)
    }
    
    func deactivate() {
        flooringOverlayLayer.resetAlpha()
        flooringOverlayLayer.clear()
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
        flooringOverlayLayer.clear()
        flooringOverlayLayer.disableAutomapping()
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: eraserShape,
                                                            ofSize: eraserSize,
                                                            centerAt: location.toGridCoordinate())
        {
            flooringOverlayLayer.setTile(toTileSet: .Eraser, at: gridCoord)
        }
        flooringOverlayLayer.enableAutomapping()
    }
    
    private func eraseTiles(at location: CGPoint) {
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: eraserShape,
                                                            ofSize: eraserSize,
                                                            centerAt: location.toGridCoordinate())
        {
            flooringLayer.clearTile(at: gridCoord)
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
