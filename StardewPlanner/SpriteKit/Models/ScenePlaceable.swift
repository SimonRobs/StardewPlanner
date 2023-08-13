//
//  ScenePlaceable.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

protocol ScenePlaceable {
    var sprite: SKSpriteNode { get }
    var type: ObjectTypes { get }
    var sizeInGrid: LibraryObjectSize { get }
    
    var hasEvenWidth: Bool { get }
    var hasEvenHeight: Bool{ get }
    var hasEvenOverflow: Bool{ get }
    
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)])
    func setPosition(_ newPosition: CGPoint)
    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite]
    func showOccupiedTiles()
    func hideOccupiedTiles()
    func containsUnbuildableTiles() -> Bool
    func setTint(_ tint: LibraryObject.Tint)
}
