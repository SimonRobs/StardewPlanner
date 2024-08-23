//
//  BackgroundLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class BackgroundLayer: SKNode, SceneLayer {
    
    private var allTiles: [[BackgroundTile]] = []
    
    private var backgroundTileMap: SKNode?
    
    init(with scene: SKScene, forSeason season: Seasons) {
        super.init()
        changeBackgroundTileMap(forSeason: season)
        subscribeObservers()
        zPosition = BackgroundLayerZPosition
        scene.addChild(self)
        
        for i in 0..<BackgroundColumns {
            allTiles.append([])
            for j in 0..<BackgroundRows {
                let t = BackgroundTile(i: i, j: j, buildable: BackgroundBuildableTiles[i][j])
                t.position.x = -frame.size.width / 2 + TileSize * CGFloat(i) + TileSize / 2
                t.position.y = frame.size.height / 2 - TileSize * CGFloat(j) - TileSize / 2
                addChild(t)
                allTiles[i].append(t)
            }
        }
    }
    
    deinit {
        unsubscribeObservers()
    }
    
    override func contains(_ p: CGPoint) -> Bool {
        return backgroundTileMap?.contains(p) ?? false
    }
    
    func getTile(at location: CGPoint) -> BackgroundTile? {
        return getTile(at: location.toGridCoordinate())
    }
    
    func getTile(at gridCoordinate: GridCoordinate) -> BackgroundTile? {
        if gridCoordinate.isOutOfBounds() { return nil }
        return allTiles[gridCoordinate.i][gridCoordinate.j]
    }
    
    func getTile(atColumn column: Int, row: Int) -> BackgroundTile? {
        if column < 0 || column >= BackgroundColumns || row < 0 || row >= BackgroundRows { return nil }
        return allTiles[column][row]
    }
    
    func isOccupied(at gridCoordinate: GridCoordinate) -> Bool {
        if let targetTile = getTile(at: gridCoordinate) {
            return targetTile.occupied
        }
        return false
    }
    
    func allowsFlooring(at gridCoordinate: GridCoordinate) -> Bool {
        if let targetTile = getTile(at: gridCoordinate) {
            return targetTile.buildable && targetTile.allowsFlooring
        }
        return false
    }
    
    func allowsFlooring(atColumn column: Int, row: Int) -> Bool {
        if let targetTile = getTile(atColumn: column, row: row) {
            return targetTile.buildable && targetTile.allowsFlooring
        }
        return false
    }
    
    func canBeOccupied(at gridCoordinate: GridCoordinate) -> Bool {
        if let targetTile = getTile(at: gridCoordinate) {
            return targetTile.buildable && !targetTile.occupied
        }
        return false
    }
    
    func canBeOccupied(atColumn column: Int, row: Int) -> Bool {
        if let targetTile = getTile(atColumn: column, row: row) {
            return targetTile.buildable && !targetTile.occupied
        }
        return false
    }
    
    func setOccupied(at coords: GridCoordinate, to occupied: Bool, allowsFlooring: Bool?) {
        let tile = getTile(at: coords)!
        tile.occupied = occupied
        tile.allowsFlooring = allowsFlooring ?? !occupied
    }
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    private func changeBackgroundTileMap(forSeason season: Seasons) {
        // TODO: add loading screen when changing the season. This may need to be done in the Farm Scene directly.
        backgroundTileMap?.removeFromParent()
        backgroundTileMap = LayoutBuilder.instance.getBackgroundTileMap(forSeason: season)
        addChild(backgroundTileMap!)
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        guard let newSeason = notification.object as? Seasons else { return }
        changeBackgroundTileMap(forSeason: newSeason)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
