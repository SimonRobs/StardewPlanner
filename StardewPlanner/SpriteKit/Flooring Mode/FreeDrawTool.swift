//
//  FreeDrawTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SpriteKit

public class FreeDrawTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .FreeDraw } }
    
    private var overlayTileMap: SKTileMapNode!
    private var selectedTileSet: TileSets = .Wood
    
    private var drawOptions = FreeDrawToolOptions()
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    private var brushSize: CGFloat {
        get {
            return drawOptions.size
        }
    }
    
    private var brushShape: FreeDrawToolOptions.BrushShapes {
        get {
            return drawOptions.shape
        }
    }
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        // FIXME: Fix overlay position breaking when even columns are selected... Also, change columns/rows back to +1
        overlayTileMap = SKTileMapNode(
            tileSet: TileSetController.instance.flooringTileSet,
            columns: Int(FreeDrawToolOptions.MaxBrushSize) + 2,
            rows: Int(FreeDrawToolOptions.MaxBrushSize) + 2,
            tileSize: CGSize(width: TileSize, height: TileSize)
        )
        overlayTileMap.alpha = 0.3
        resetOverlay(to: selectedTileSet)
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() {
        hideOverlay()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        showOverlay()
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        hideOverlay()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        if overlayTileMap.parent == nil { showOverlay() }
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        hideOverlay()
        drawTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        showOverlay()
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        drawTiles(at: event.location)
    }
    
    private func showOverlay() {
        if(overlayTileMap.scene != nil) { return }
        scene.addChild(overlayTileMap)
    }
    
    private func hideOverlay() {
        if(overlayTileMap.scene == nil) { return }
        overlayTileMap.removeFromParent()
    }
    
    private func moveSelectedSprite(to location: CGPoint) {
        overlayTileMap.position = location
    }
    
    @objc private func handleTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        selectedTileSet = tileSet
        resetOverlay(to: tileSet)
    }
    
    private func drawTiles(at location: CGPoint) {
        // FIXME: Brush size does not work for even sizes
        var allLocations: [CGPoint] = []
        let radius = CGFloat(Int(brushSize / 2))
        for xOffset in stride(from: -TileSize * radius, through: TileSize * radius, by: TileSize) {
            for yOffset in stride(from: -TileSize * radius, through: TileSize * radius, by: TileSize) {
                allLocations.append(CGPoint(x: location.x + xOffset, y: location.y + yOffset))
            }
        }
        
        for location in allLocations {
            tileMap.setFlooringTile(toTileSet: selectedTileSet, at: location, ignoringPreviousTile: false)
        }
    }
    
    private func resetOverlay(to tileSet: TileSets) {
        
        overlayTileMap.fill(with: nil)
        
        let center = overlayTileMap.numberOfColumns / 2
        let radius = Int(brushSize / 2)
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        guard let tileGroup = flooringTileGroups.first(where: {g in g.name == tileSet.rawValue}) else { return }
        for column in (center - radius)...(center + radius) {
            for row in (center - radius)...(center + radius) {
                overlayTileMap.setTileGroup(tileGroup, forColumn: column, row: row)
            }
        }
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? FreeDrawToolOptions else { return }
        drawOptions = options
        resetOverlay(to: selectedTileSet)
        // TODO: Implement brush shape change
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onPrimaryTileChanged, callbackSelector: #selector(handleTileChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onFreeDrawToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
