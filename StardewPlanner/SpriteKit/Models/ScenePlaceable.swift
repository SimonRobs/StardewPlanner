//
//  ScenePlaceable.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

protocol ScenePlaceable {
    var type: ObjectTypes { get }
    var sizeInGrid: LibraryObjectSize { get }
    
    var hasEvenWidth: Bool { get }
    var hasEvenHeight: Bool{ get }
    var hasEvenOverflow: Bool{ get }
    var hasParent: Bool { get }
    
    func getSprite() -> SKNode
    func getSpriteInternal() -> SKSpriteNode // Only called by the modifiers
    
    func addModifier(ofType type: ModifierTypes, _ modifier: LibraryObjectModifier)
    func hasModifier(ofType type: ModifierTypes) ->  Bool
    func getModifier(ofType type: ModifierTypes) -> LibraryObjectModifier?
    
    func removeFromParent()
    func hideVerticalOverflow()
    func showVerticalOverflow()
    
    func contains(_ location: CGPoint) -> Bool
    func setSubsprites(subsprites: [(SKSpriteNode, CGPoint3D)])
    func setPosition(_ newPosition: CGPoint)
    func getOccupiedTiles() -> [LibraryObjectPlacementTileSprite]
    func showOccupiedTiles()
    func hideOccupiedTiles()
    func cannotBePlaced() -> Bool
    func setTint(_ tint: LibraryObject.Tint)
}
