//
//  FlooringTileMap.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class FlooringTileMap: SKTileMapNode {
    private var selectedFlooringTile: SKSpriteNode!
    private var previousTile: BackgroundTile? = nil
    
    override init() {
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
        let halfTileSize = TileSize / 2
        let xOffset: CGFloat = location.x < 0 ? -halfTileSize : halfTileSize
        let yOffset: CGFloat = location.y < 0 ? -halfTileSize : halfTileSize
        selectedFlooringTile.position.x = (location.x - location.x.truncatingRemainder(dividingBy: TileSize) + xOffset).rounded()
        selectedFlooringTile.position.y = (location.y - (location.y - halfTileSize).truncatingRemainder(dividingBy: TileSize)).rounded() + yOffset
    }
    
    private func drawFlooringTile(at location: CGPoint, ignoringPreviousTile: Bool = true) {
        guard let scene = scene else { return }
        guard let background = scene.childNode(withName: BackgroundSpriteName) else { return }
        
        let candidateNodes = background.nodes(at: location)
        if candidateNodes.isEmpty { return }
        guard let targetTile = (candidateNodes[0] as? BackgroundTile) else { return }
        hideSelectedSprite()
        
        if !ignoringPreviousTile && targetTile == previousTile || !targetTile.buildable { return }
        if ignoringPreviousTile && !targetTile.buildable { return }
        previousTile = targetTile
        
        let flooringTileGroups = TileSetController.instance.flooringTileSet.tileGroups
        guard let tileGroup = flooringTileGroups.first(where: {g in g.name == selectedFlooringTile.name}) else { return }
        setTileGroup(tileGroup, forColumn: targetTile.i, row: BackgroundRows - 1 - targetTile.j)
    }
    
}
