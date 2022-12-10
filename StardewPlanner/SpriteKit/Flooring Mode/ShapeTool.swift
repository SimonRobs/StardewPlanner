//
//  ShapeTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class ShapeTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Shape } }
    
    private var drawOptions = ShapeToolOptions()
    
    private var overlayTileMap: SKTileMapNode!
    private var fillTileSet: TileSets = .Wood
    private var strokeTileSet: TileSets = .Empty
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    private var startCoordinates: GridCoordinate? = nil
    private var endCoordinates: GridCoordinate? = nil
    
    private var shape: ShapeToolOptions.Shapes {
        get {
            return drawOptions.shape
        }
    }
    
    private var strokeWidth: CGFloat {
        get {
            return drawOptions.strokeWidth
        }
    }
    
    
    private var topLeftCorner: GridCoordinate? {
        get {
            startCoordinates == nil || endCoordinates == nil ? nil : GridCoordinate(
                i: min(startCoordinates!.i, endCoordinates!.i),
                j: max(startCoordinates!.j, endCoordinates!.j)
            )
        }
    }
    
    private var bottomRightCorner: GridCoordinate? {
        get {
            startCoordinates == nil || endCoordinates == nil ? nil : GridCoordinate(
                i: max(startCoordinates!.i, endCoordinates!.i),
                j: min(startCoordinates!.j, endCoordinates!.j)
            )
        }
    }
    
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        overlayTileMap = SKTileMapNode(
            tileSet: TileSetController.instance.flooringTileSet,
            columns: BackgroundColumns,
            rows: BackgroundRows,
            tileSize: CGSize(width: TileSize, height: TileSize)
        )
        overlayTileMap.alpha = 0.3
        scene.addChild(overlayTileMap)
        
        clearOverlay()
        
        subscribe()
    }
    
    func activate() {
        clearOverlay()
    }
    
    func deactivate() {
        clearOverlay()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        moveOverlayTile(to: event.location)
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        clearOverlay()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        moveOverlayTile(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        startCoordinates = event.location.toGridCoordinate()
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        drawShape()
        clearOverlay()
        startCoordinates = nil
        endCoordinates = nil
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        if endCoordinates == event.location.toGridCoordinate() { return }
        endCoordinates = event.location.toGridCoordinate()
        updateOverlay()
    }
    
    private func drawShape() {
        guard let topLeftCorner = topLeftCorner, let bottomRightCorner = bottomRightCorner else { return }
        
        for col in topLeftCorner.i ... bottomRightCorner.i {
            for row in bottomRightCorner.j ... topLeftCorner.j {
                tileMap.setFlooringTile(
                    toTileSet: getTileSet(atColumn: col, row: row),
                    forColumn: col,
                    row: row
                )
            }
        }
    }
    
    private func getTileSet(atColumn column: Int, row: Int) -> TileSets? {
        guard let topLeftCorner = topLeftCorner, let bottomRightCorner = bottomRightCorner else { return nil }
        
        var tileSet = strokeTileSet != .Empty ? strokeTileSet : fillTileSet != .Empty ? fillTileSet : .Empty
        if strokeTileSet != .Empty && row >= bottomRightCorner.j + Int(strokeWidth) && row <= topLeftCorner.j - Int(strokeWidth) &&
           column >= topLeftCorner.i + Int(strokeWidth) && column <= bottomRightCorner.i - Int(strokeWidth)
        {
            tileSet = fillTileSet
        }
        return tileSet
    }
    
    private func moveOverlayTile(to location: CGPoint) {
        clearOverlay()
        let positionInGrid = location.toGridCoordinate()
        let tileGroup = TileSetController.instance.flooringTileSet.tileGroups.first(where: {$0.name == strokeTileSet.rawValue || $0.name == fillTileSet.rawValue})
        overlayTileMap.setTileGroup(tileGroup, forColumn: positionInGrid.i, row: BackgroundRows - positionInGrid.j - 1)
    }
    
    private func updateOverlay() {
        clearOverlay()
        guard let topLeftCorner = topLeftCorner, let bottomRightCorner = bottomRightCorner else { return }
        
        for col in topLeftCorner.i ... bottomRightCorner.i {
            for row in bottomRightCorner.j ... topLeftCorner.j {
                let tileGroup = TileSetController.instance.flooringTileSet.tileGroups.first(where: {$0.name == getTileSet(atColumn: col, row: row)?.rawValue})
                overlayTileMap.setTileGroup(tileGroup, forColumn: col, row:  BackgroundRows - row - 1)
            }
        }
    }
    
    private func clearOverlay() {
        overlayTileMap.fill(with: nil)
    }
    
    @objc private func handleFillTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        fillTileSet = tileSet
    }
    
    @objc private func handleStrokeTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        strokeTileSet = tileSet
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? ShapeToolOptions else { return }
        drawOptions = options
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onShapeToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onPrimaryTileChanged, callbackSelector: #selector(handleFillTileChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onSecondaryTileChanged, callbackSelector: #selector(handleStrokeTileChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
}
