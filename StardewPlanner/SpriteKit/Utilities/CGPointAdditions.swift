//
//  CGPointAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-15.
//

import SpriteKit

extension CGPoint {
    
    func add(_ p: CGPoint) -> CGPoint {
        return CGPoint(x: x + p.x, y: y + p.y)
    }
    
    func toGridCoordinate() -> GridCoordinate {
        return GridCoordinate(
            i: Int((x + BackgroundSize.width / 2 - TileSize / 2) / TileSize),
            j: Int((BackgroundSize.height / 2 - y - TileSize / 2) / TileSize)
        )
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    
}
