//
//  RangedDecorator.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class RangedDecorator: LibraryObjectDecorator {
    
    let area: LibraryObjectArea
    
    init(_ object: ScenePlaceable, area: LibraryObjectArea) {
        self.area = area
        super.init(object)
        let tilePositions: [CGPoint] = ShapeProvider.getTiles(for: area.shape, with: area.radius)
        // TODO: Show the range on the actual background tiles instead of adding new tiles.
        //       (This is because new range tiles overshadow previously placed objects)
        for position in tilePositions {
            let rangeTile = SKSpriteNode(imageNamed: "Green Tile")
            rangeTile.name = LibraryObject.PlacementTileName
            rangeTile.position = position
            rangeTile.zPosition = position.equalTo(sprite.position) ? -1 : RangeOverlayTilesZPosition
            if object.hasEvenHeight { rangeTile.position.y -= TileSize / 2 }
        }
        
        NotificationController.instance.subscribe(observer: self, name: .onShowObjectRangeChanged, callbackSelector: #selector(handleShowRangeChanged), object: nil)
    }
    
    func hideArea() {
        sprite.enumerateChildNodes(withName: LibraryObject.PlacementTileName, using: { child, _  in
            child.alpha = 0
        })
    }
    
    func showArea() {
        sprite.enumerateChildNodes(withName: LibraryObject.PlacementTileName, using: { child, _  in
            child.alpha = 1
        })
    }
    
    @objc private func handleShowRangeChanged(_ notification: Notification) {
        guard let isRangeShown = notification.object as? Bool else { return }
        if isRangeShown {
            showArea()
        } else {
            hideArea()
        }
    }
}
