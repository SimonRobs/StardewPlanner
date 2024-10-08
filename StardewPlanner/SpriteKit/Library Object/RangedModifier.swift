//
//  RangedModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class RangedModifier: LibraryObjectModifier {
    var type: ModifierTypes = .Ranged
    var object: any ScenePlaceable
    
    private let area: LibraryObjectArea
    private var tilePositions: [CGPoint]
    
    init(_ object: ScenePlaceable, area: LibraryObjectArea) {
        self.area = area
        self.object = object
        
        tilePositions = ShapeProvider.getTiles(for: area.shape, with: area.radius)
            .map { position in
                CGPoint(x: position.x, y: position.y - CGFloat(Int(object.sizeInGrid.rows / 2)) * TileSize)
            }
            .filter { position in
                return !object.getOccupiedTiles().contains { tile in
                    return (tile.position.x == position.x && (tile.position.y + (object.hasEvenHeight ? TileSize / 2 : 0)) == position.y)
                }
            }
        for position in tilePositions {
            let rangeTile = SKSpriteNode(imageNamed: "Green Tile")
            rangeTile.name = ObjectPlacementTileName
            rangeTile.position = position
            rangeTile.zPosition = RangeOverlayLayerZPosition
            if object.hasEvenHeight { rangeTile.position.y -= TileSize / 2 }
            object.getSprite().addChild(rangeTile)
        }
    }
    
    func getTilePositions() -> [CGPoint] {
        let pos = object.getSprite().position
        return tilePositions.map { position in
            CGPoint(
                x: position.x + pos.x,
                y: position.y + pos.y + (object.hasEvenHeight ? -TileSize / 2 : 0)
            )
        }
    }
    
    func hideArea() {
        object.getSprite().enumerateChildNodes(withName: ObjectPlacementTileName, using: { child, _  in
            child.alpha = 0
        })
    }
    
    func showArea() {
        object.getSprite().enumerateChildNodes(withName: ObjectPlacementTileName, using: { child, _  in
            child.alpha = 1
        })
    }
}
