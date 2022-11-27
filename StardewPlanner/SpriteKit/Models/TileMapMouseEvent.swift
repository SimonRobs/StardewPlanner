//
//  TileMapMouseEvent.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-26.
//

import SpriteKit

struct TileMapMouseEvent {
    
    var location: CGPoint = .zero
    
    init(from event: NSEvent, in scene: SKScene) {
        location = snapToTile(event.location(in: scene))
    }
    
    private func snapToTile(_ location: CGPoint) -> CGPoint {
        let halfTileSize = TileSize / 2
        let xOffset: CGFloat = location.x < 0 ? -halfTileSize : halfTileSize
        return CGPoint(
            x: (location.x - location.x.truncatingRemainder(dividingBy: TileSize) + xOffset).rounded(),
            y: (location.y / TileSize).rounded() * TileSize
        )
    }
}
