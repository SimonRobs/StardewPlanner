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
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
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
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() {
        tileMap.overlay.clear()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        tileMap.overlay.clear()
        drawTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        drawTiles(at: event.location)
    }

    private func moveSelectedSprite(to location: CGPoint) {
        tileMap.overlay.clear()
        for gridCoord in BrushShapeCreator.GetFlooringTiles(inShape: brushShape,
                                                            ofSize: brushSize,
                                                            centerAt: location.toGridCoordinate())
        {
            tileMap.overlay.setFlooringTile(toTileSet: selectedTileSet, at: gridCoord)
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
            tileMap.setFlooringTile(toTileSet: selectedTileSet, forColumn: gridCoord.i, row: gridCoord.j)
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
