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
    
    override func mouseEntered(with event: NSEvent) {
        showSelectedSprite()
    }
    
    override func mouseExited(with event: NSEvent) {
        hideSelectedSprite()
    }
    
    override func mouseMoved(with event: NSEvent) {
        guard let scene = scene else { return }
        let location = event.location(in: scene)
        moveSelectedSprite(to: location)
    }
    
    
    override func mouseDown(with event: NSEvent) {
        guard let scene = scene else { return }
        let location = event.location(in: scene)
        drawFlooringTile(at: location, ignoringPreviousTile: false)
    }
    
    override func mouseUp(with event: NSEvent) {
        guard let scene = scene else { return }
        let location = event.location(in: scene)
        showSelectedSprite()
        moveSelectedSprite(to: location)
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let scene = scene else { return }
        let location = event.location(in: scene)
        drawFlooringTile(at: location)
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
        var adaptedLocation = location
        adaptedLocation.y -= TileSize / 2
        selectedFlooringTile.position = SnapToTile(adaptedLocation)
        selectedFlooringTile.position.y += TileSize / 2
    }
    
    private func drawFlooringTile(at location: CGPoint, ignoringPreviousTile: Bool = true) {
        var adjustedLocation = location
        adjustedLocation.x += TileSize / 2
        adjustedLocation.y -= TileSize / 2
        guard let targetTile = background.getTile(at: adjustedLocation) else { return }
        hideSelectedSprite()
        
        if !ignoringPreviousTile && targetTile == previousTile || !targetTile.buildable { return }
        if ignoringPreviousTile && !targetTile.buildable { return }
        previousTile = targetTile
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        guard let tileGroup = flooringTileGroups.first(where: {g in g.name == selectedFlooringTile.name}) else { return }
        setTileGroup(tileGroup, forColumn: targetTile.i, row: BackgroundRows - 1 - targetTile.j)
    }
}
