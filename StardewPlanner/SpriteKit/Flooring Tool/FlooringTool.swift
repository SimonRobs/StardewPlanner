//
//  FlooringTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-01.
//

import SpriteKit

public class FlooringTool {
    
    private var selectedFlooringTile: SKSpriteNode!
    private var brushRadius: CGFloat = 2
    
    private var tileMap: FlooringTileMap
    private var scene: SKScene
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        self.scene = scene
        self.tileMap = tileMap
        setFlooringTile(ofType: .Wood)
    }
    
    func setFlooringTile(ofType tileType: TileSets) {
        let textureName = "\(tileType.rawValue) Center Solo"
        
        if selectedFlooringTile == nil {
            selectedFlooringTile = SKSpriteNode(imageNamed: textureName)
        } else {
            selectedFlooringTile.texture = SKTexture(imageNamed: textureName)
        }
        
        selectedFlooringTile.size = CGSize(width: TileSize, height: TileSize)
        selectedFlooringTile.name = tileType.rawValue
        selectedFlooringTile.alpha = 0.3
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        showSelectedSprite()
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        hideSelectedSprite()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        if selectedFlooringTile.parent == nil { showSelectedSprite() }
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        var allLocations: [CGPoint] = []
        
        for xOffset in stride(from: -TileSize * brushRadius, through: TileSize * brushRadius, by: TileSize) {
            for yOffset in stride(from: -TileSize * brushRadius, through: TileSize * brushRadius, by: TileSize) {
                allLocations.append(CGPoint(x: event.location.x + xOffset, y: event.location.y + yOffset))
            }
        }
        
        for location in allLocations {
            tileMap.setFlooringTile(selectedFlooringTile, at: location, ignoringPreviousTile: false)
        }
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        showSelectedSprite()
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        var allLocations: [CGPoint] = []
        
        for xOffset in stride(from: -TileSize * brushRadius, through: TileSize * brushRadius, by: TileSize) {
            for yOffset in stride(from: -TileSize * brushRadius, through: TileSize * brushRadius, by: TileSize) {
                allLocations.append(CGPoint(x: event.location.x + xOffset, y: event.location.y + yOffset))
            }
        }
        
        for location in allLocations {
            tileMap.setFlooringTile(selectedFlooringTile, at: location)
        }
    }
    
    private func showSelectedSprite() {
        if(selectedFlooringTile.scene != nil) { return }
        scene.addChild(selectedFlooringTile)
    }
    
    private func hideSelectedSprite() {
        if(selectedFlooringTile.scene == nil) { return }
        selectedFlooringTile.removeFromParent()
    }
    
    private func moveSelectedSprite(to location: CGPoint) {
        selectedFlooringTile.position = location
    }
    
}
