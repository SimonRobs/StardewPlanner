//
//  EraserTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class EraserTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Eraser } }
    
    private var borderSprite: SKSpriteNode!
    
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
        
        // TODO: Find a better way to implement the eraser border
        borderSprite = SKSpriteNode(imageNamed: "Eraser Border Square")
        borderSprite.size = borderSize
        
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
        if borderSprite.parent == nil { showOverlay() }
        moveBorderSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        eraseTiles(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        showOverlay()
        moveBorderSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        moveBorderSprite(to: event.location)
        eraseTiles(at: event.location)
    }
    
    private func showOverlay() {
        if(borderSprite.scene != nil) { return }
        scene.addChild(borderSprite)
    }
    
    private func hideOverlay() {
        if(borderSprite.scene == nil) { return }
        borderSprite.removeFromParent()
    }
    
    private func moveBorderSprite(to location: CGPoint) {
        borderSprite.position = location
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
        borderSprite.size = borderSize
        // TODO: Implement brush shape change
    }

    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onEraserToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
