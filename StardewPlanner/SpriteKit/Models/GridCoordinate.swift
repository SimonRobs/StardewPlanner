//
//  GridCoordinate.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-15.
//

import Foundation

struct GridCoordinate {
    let i: Int // Column == X
    let j: Int // Row == Y
    
    func isOutOfBounds() -> Bool {
        return (i < 0 || i >= BackgroundColumns || j < 0 || j >= BackgroundRows)
    }
    
    func toLocation() -> CGPoint {
        return CGPoint(
            x: CGFloat(i) * TileSize - BackgroundSize.width / 2 + TileSize / 2,
            y: BackgroundSize.height / 2 - CGFloat(j) * TileSize
        )
    }
}
