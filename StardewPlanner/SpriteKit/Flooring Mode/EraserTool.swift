//
//  EraserTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class EraserTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Eraser } }
    
    private var overlayTileMap: SKTileMapNode!
    
    private var drawOptions = EraserToolOptions()
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    private var eraserSize: CGFloat {
        get {
            return drawOptions.size
        }
    }
    
    private var borderSize: CGSize {
        get {
            return CGSize(width: eraserSize * TileSize, height: eraserSize * TileSize)
        }
    }
    
    private var eraserShape: EraserToolOptions.BrushShapes {
        get {
            return drawOptions.shape
        }
    }
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        
        createOverlayTilemap()
        resetOverlay()
        
        subscribe()
    }
    
    func activate() {  }
    
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
        moveOverlay(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        eraseTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        showOverlay()
        moveOverlay(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        moveOverlay(to: event.location)
        eraseTiles(at: event.location)
    }
    
    private func showOverlay() {
        if(overlayTileMap.scene != nil) { return }
        scene.addChild(overlayTileMap)
    }
    
    private func hideOverlay() {
        if(overlayTileMap.scene == nil) { return }
        overlayTileMap.removeFromParent()
    }
    
    private func moveOverlay(to location: CGPoint) {
        overlayTileMap.position = location
    }
    
    private func eraseTiles(at location: CGPoint) {
        // FIXME: Brush size does not work for even sizes
        var allLocations: [CGPoint] = []
        let radius = CGFloat(Int(eraserSize / 2))
        for xOffset in stride(from: -TileSize * radius, through: TileSize * radius, by: TileSize) {
            for yOffset in stride(from: -TileSize * radius, through: TileSize * radius, by: TileSize) {
                allLocations.append(CGPoint(x: location.x + xOffset, y: location.y + yOffset))
            }
        }
        
        for location in allLocations {
            tileMap.setFlooringTile(toTileSet: nil, at: location, ignoringPreviousTile: false)
        }
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? EraserToolOptions else { return }
        drawOptions = options
        resetOverlay()
        // TODO: Implement brush shape change
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onEraserToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    private func resetOverlay() {
        
        overlayTileMap.fill(with: nil)
        
        let center = overlayTileMap.numberOfColumns / 2
        let radius = Int(eraserSize / 2)
        
        // If automapping is enabled while filling up the tilemap, it will break
        // because we do not yet have sprite the definitions for all the sprites
        overlayTileMap.enableAutomapping = false
        let tileGroup = overlayTileMap.tileSet.tileGroups[0]
        for column in (center - radius)...(center + radius) {
            for row in (center - radius)...(center + radius) {
                overlayTileMap.setTileGroup(tileGroup, forColumn: column, row: row)
            }
        }
        overlayTileMap.enableAutomapping = true
    }
    
    private func createOverlayTilemap() {
        var rules: [SKTileGroupRule] = []
        
        rules.append(SKTileGroupRule(adjacency: [], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Center Solo"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyAll], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Center"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyUp), .adjacencyLowerLeft,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Up Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyDown),.adjacencyUpperLeft,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Down Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyLeft),.adjacencyUpperRight,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Left Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyRight),.adjacencyUpperLeft,.adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Right Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyDown,.adjacencyRight, .adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Upper Left Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyRight,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Lower Left Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyLeft,.adjacencyUpperLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Lower Right Edge"))]))
        rules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyDown, .adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "Eraser Upper Right Edge"))]))
        
        overlayTileMap = SKTileMapNode(
            tileSet: SKTileSet(tileGroups: [SKTileGroup(rules: rules)]),
            columns: Int(EraserToolOptions.MaxBrushSize) + 2,
            rows: Int(EraserToolOptions.MaxBrushSize) + 2,
            tileSize: CGSize(width: TileSize, height: TileSize)
        )
    }
}
