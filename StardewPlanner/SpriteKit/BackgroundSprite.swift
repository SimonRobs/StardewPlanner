//
//  BackgroundSprite.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class BackgroundSprite: SKSpriteNode {
    
    private var allTiles: [[BackgroundTile]] = []
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Default Spring"), color:.clear, size: BackgroundSize)
        
        name = BackgroundSpriteName
        
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
    
    func setBuildableStatus(at coords: GridCoordinate, to status: Bool) {
        allTiles[coords.i][coords.j].buildable = status
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
}
