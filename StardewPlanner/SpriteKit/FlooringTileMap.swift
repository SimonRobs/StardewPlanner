//
//  FlooringTileMap.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class FlooringTileMap: SKTileMapNode {
    private var background: BackgroundSprite
    
    private var selectedFlooringTile: SKSpriteNode!
    private var previousTile: BackgroundTile? = nil
    
    init(on background: BackgroundSprite) {
        self.background = background
        super.init(tileSet: TileSetController.instance.flooringTileSet,
                   columns: BackgroundColumns,
                   rows: BackgroundRows,
                   tileSize: CGSize(width: TileSize, height: TileSize)
        )
        setFlooringTile(ofType: .Wood)
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
        drawFlooringTile(at: event.location, ignoringPreviousTile: false)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        showSelectedSprite()
        moveSelectedSprite(to: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        drawFlooringTile(at: event.location)
    }
    
    func clearFlooringTile(at coords: GridCoordinate) {
        setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    public func setFlooringTile(ofType tileType: TileSets) {
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    private func showSelectedSprite() {
        guard let scene = scene else { return }
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
    
    private func drawFlooringTile(at location: CGPoint, ignoringPreviousTile: Bool = true) {
        guard let targetTile = background.getTile(at: location) else { return }
        hideSelectedSprite()
        
        if !ignoringPreviousTile && targetTile == previousTile || !targetTile.buildable { return }
        if ignoringPreviousTile && !targetTile.buildable { return }
        previousTile = targetTile
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        guard let tileGroup = flooringTileGroups.first(where: {g in g.name == selectedFlooringTile.name}) else { return }
        setTileGroup(tileGroup, forColumn: targetTile.i, row: BackgroundRows - 1 - targetTile.j)
    }
}
