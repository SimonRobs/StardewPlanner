//
//  FreeDrawTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SpriteKit

public class FreeDrawTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .FreeDraw } }
    
    private var selectedTileSet: TileSets = .Wood
    
    private var drawOptions = FreeDrawToolOptions()
    
    private let backgroundLayer: BackgroundLayer
    private let flooringLayer: FlooringLayer
    private let flooringOverlayLayer: FlooringOverlayLayer
    
    private var brushSize: CGFloat {
        get {
            return drawOptions.size
        }
    }
    
    private var brushShape: BrushShapes {
        get {
            return drawOptions.shape
        }
    }
    
    init() {
        backgroundLayer = LayersManager.instance.getLayer(ofType: .Background) as! BackgroundLayer
        flooringLayer = LayersManager.instance.getLayer(ofType: .Flooring) as! FlooringLayer
        flooringOverlayLayer = LayersManager.instance.getLayer(ofType: .FlooringOverlay) as! FlooringOverlayLayer
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() {
        flooringOverlayLayer.clear()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        flooringOverlayLayer.clear()
        drawTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        drawTiles(at: event.location)
    }
    
    private func moveSelectedSprite(to location: CGPoint) {
        flooringOverlayLayer.clear()
        for gridCoord in BrushShapeCreator.GetFlooringTiles(
            inShape: brushShape,
            ofSize: brushSize,
            centerAt: location.toGridCoordinate())
        {
            flooringOverlayLayer.setTile(toTileSet: selectedTileSet, at: gridCoord)
        }
    }
    
    @objc private func handleTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        selectedTileSet = tileSet
    }
    
    private func drawTiles(at location: CGPoint) {
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: brushShape,
                                                            ofSize: brushSize,
                                                            centerAt: location.toGridCoordinate())
        {
            if backgroundLayer.canBeOccupied(at: gridCoord) {
                flooringLayer.setTile(toTileSet: selectedTileSet, forColumn: gridCoord.i, row: gridCoord.j)
            }
        }
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? FreeDrawToolOptions else { return }
        drawOptions = options
    }
    
    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onPrimaryTileChanged, callbackSelector: #selector(handleTileChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onFreeDrawToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
