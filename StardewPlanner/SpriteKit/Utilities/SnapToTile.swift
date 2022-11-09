//
//  SnapToTile.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import Foundation

func SnapToTile(_ location: CGPoint) -> CGPoint {
    let halfTileSize = TileSize / 2
    let xOffset: CGFloat = location.x < 0 ? -halfTileSize : halfTileSize
    let yOffset: CGFloat = location.y < 0 ? -halfTileSize : halfTileSize
    return CGPoint(
        x: (location.x - location.x.truncatingRemainder(dividingBy: TileSize) + xOffset).rounded(),
        y: (location.y - location.y.truncatingRemainder(dividingBy: TileSize) + yOffset).rounded()
    )
}
