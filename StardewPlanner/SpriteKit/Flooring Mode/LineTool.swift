//
//  LineTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class LineTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Line } }
    
    private var overlayTileMap: SKTileMapNode!
    private var selectedTileSet: TileSets = .Wood
    
    private var drawOptions = LineToolOptions()
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    private var lineStart: GridCoordinate?
    private var lineEnd: GridCoordinate?
    
    private var strokeWidth: CGFloat {
        get {
            return drawOptions.strokeWidth
        }
    }
    
    private var lineCap: LineToolOptions.LineCaps {
        get {
            return drawOptions.lineCap
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
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() {
        overlayTileMap.removeFromParent()
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        showOverlay()
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        hideOverlay()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        lineStart = event.location.toGridCoordinate()
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        drawTiles()
        lineStart = event.location.toGridCoordinate()
        lineEnd = nil
        updateOverlay()
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        lineEnd = event.location.toGridCoordinate()
        updateOverlay()
    }
    
    private func showOverlay() {
        // TODO: Show Overlay
    }
    
    private func hideOverlay() {
        // TODO: Hide Overlay
    }
    
    private func moveSelectedSprite(to location: CGPoint) {
        // TODO: Update overlay tiles positions
    }
    
    @objc private func handleStrokeTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        selectedTileSet = tileSet
    }
    
    private func drawTiles() {
        for tileCoords in getTilesToDraw() {
            tileMap.setFlooringTile(toTileSet: selectedTileSet, forColumn: tileCoords.i, row: tileCoords.j)
        }
    }
    
    private func updateOverlay() {
        
        overlayTileMap.fill(with: nil)
        
        let tileGroup = TileSetController.instance.flooringTileSet.tileGroups.first(where: {$0.name == selectedTileSet.rawValue})
        
        for tileCoords in getTilesToDraw() {
            overlayTileMap.setTileGroup(tileGroup, forColumn: tileCoords.i, row:  BackgroundRows - tileCoords.j - 1)
        }
    }
    
    // Bresenham's Line Algorithm
    /// Adapted to SpriteKit from https://github.com/RockLobster/Bresenham-Swift/blob/master/Bresenham/Bresenham.swift
    private func getTilesToDraw() -> [GridCoordinate] {
        var tilesToDraw: [GridCoordinate] = []
        
        guard var start = lineStart else { return [] }
        var end = GridCoordinate(i: lineEnd?.i ?? start.i, j: lineEnd?.j ?? start.j)

        let isSteep = abs(end.j - start.j) > abs(end.i - start.i)
        if isSteep {
            start = GridCoordinate(i: start.j, j: start.i)
            end = GridCoordinate(i: end.j, j: end.i)
        }
        
        if end.i < start.i {
            let oldStart = start
            start = end
            end = oldStart
        }
        
        
        let deltaX = end.i - start.i
        let deltaY = end.j - start.j
        
        let yStep = (deltaY >= 0) ? 1 : -1
        let slope = abs(Float(deltaY)/Float(deltaX))
        var error: Float = 0
        var y = start.j
        
        for x in start.i...end.i {
            tilesToDraw.append(
                isSteep ? GridCoordinate(i:y, j:x) : GridCoordinate(i:x, j:y)
            )
            error += slope
            if error >= 0.5 {
                y += yStep
                error -= 1
            }

        }

        return tilesToDraw
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? LineToolOptions else { return }
        drawOptions = options
        updateOverlay()
        // TODO: Implement line cap change
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onSecondaryTileChanged, callbackSelector: #selector(handleStrokeTileChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onLineToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
