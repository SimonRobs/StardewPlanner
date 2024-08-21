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
    private let overlayTileMap: RangeOverlayTileMap
    
    init(_ object: ScenePlaceable, area: LibraryObjectArea, overlayTileMap: RangeOverlayTileMap) {
        self.area = area
        self.object = object
        self.overlayTileMap = overlayTileMap
        
        let tilePositions: [CGPoint] = ShapeProvider.getTiles(for: area.shape, with: area.radius)
        // TODO: Show the range on the actual background tiles instead of adding new tiles.
        //       (This is because new range tiles overshadow previously placed objects)
        for position in tilePositions {
            let rangeTile = SKSpriteNode(imageNamed: "Green Tile")
            rangeTile.name = LibraryObject.PlacementTileName
            rangeTile.position = position
            rangeTile.zPosition = position.equalTo(object.sprite.position) ? -1 : RangeOverlayTilesZPosition
            if object.hasEvenHeight { rangeTile.position.y -= TileSize / 2 }
            object.sprite.addChild(rangeTile)
        }
        
        NotificationController.instance.subscribe(observer: self, name: .onShowObjectRangeChanged, callbackSelector: #selector(handleShowRangeChanged), object: nil)
    }
    
    func hideArea() {
        object.sprite.enumerateChildNodes(withName: LibraryObject.PlacementTileName, using: { child, _  in
            child.alpha = 0
        })
    }
    
    func showArea() {
        object.sprite.enumerateChildNodes(withName: LibraryObject.PlacementTileName, using: { child, _  in
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
