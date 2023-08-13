//
//  LibraryObjectDecorator.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class LibraryObjectDecorator: ScenePlaceable {
    
    private var object: ScenePlaceable
    
    var sprite: SKSpriteNode { return object.sprite }
    var type: ObjectTypes { return object.type }
    var sizeInGrid: LibraryObjectSize { return object.sizeInGrid }
    var hasEvenWidth: Bool { return object.hasEvenWidth }
    var hasEvenHeight: Bool { return object.hasEvenHeight }
    var hasEvenOverflow: Bool { return object.hasEvenOverflow }
    
    init(_ object: ScenePlaceable) {
        self.object = object
    }
    
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)]) { object.setSubsprites(subsprites: subsprites) }
    func setPosition(_ newPosition: CGPoint) { object.setPosition(newPosition) }
    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite] { return object.getOccupiedTiles() }
    func showOccupiedTiles() { object.showOccupiedTiles() }
    func hideOccupiedTiles() { object.hideOccupiedTiles() }
    func containsUnbuildableTiles() -> Bool { return object.containsUnbuildableTiles() }
    func setTint(_ tint: LibraryObject.Tint) { object.setTint(tint) }
}
