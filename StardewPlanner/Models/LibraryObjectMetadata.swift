//
//  LibraryObjectMetadata.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

struct LibraryObjectMetadata  {
    // Size of the object in the game grid
    var size = LibraryObjectSize()

    // Definition of the extension of a building (the greenhouse)
    var sizeExtension: LibraryObjectSizeExtension?

    // Names and offsets of subtextures
    var subtextures: [LibraryObjectSubtexture]?

    // Texture name of the variant, like the broken greenhouse
    var alternativeTextures: [String]?

    // Upgrades information for the object
    var upgrades: [LibraryObjectUpgradeData]?

    // Only for items composed solely from subtextures (like the fish pond)
    var noTexture: Bool?

    // Scene name for the layout of the wanted building
    var layoutName: String?

    // Area definition for a ranged object
    var area: LibraryObjectArea?

    // If true, the item will only be placeable in placeable Background Tiles marked as isWater (Like the Crab Pot)
    var inWaterOnly: Bool?

    // If true, the building shadow will be drawn
    var hasBuildingShadow: Bool?

    // If true, the object will only be placeable during the seasons listed in seasons
    // If seasons is nil, then the object will be placeable during any season but will
    // react nonetheless to season changes and will look for the texture "\(season) \(type)"
    var seasonal: Bool?

    // List of seasons during which the object can be placed
    var seasons: [Seasons]?

    // List of accepted sprite tints. The algorithms looks for "White \(type)"
    var tints: [String]?

    // If true, hoed dirt will have in-water dirt texture
    var isPaddyCrop: Bool?

    // If true, the option to toggle giant/normal crop will be available.
    // Looks for "Giant \(name)"
    // Object Size for giant crops is always 3x3x1
    var canBeGiant: Bool?
    
    // If true, only one item of the same type can be placed on the farm
    var maxPlaceable: Int?
    
    // If true, placing this item on a floor tile will not remove it
    var canBePlacedOnFlooring: Bool?

}

extension LibraryObjectMetadata {
    static let Invalid = LibraryObjectMetadata(size: LibraryObjectSize(columns: -1, rows: -1))
}

struct LibraryObjectSize {
    var columns: Int = 1
    var rows: Int = 1
    var verticalOverflow: Int = 1
    
    static let zero = LibraryObjectSize(columns: 0, rows: 0, verticalOverflow: 0)
}

struct LibraryObjectSizeExtension {
    var columns: Int
    var rows: Int
    var textureName: String
    var offset: CGPoint
}

struct LibraryObjectSubtexture {
    var name: String
    var offset: CGPoint3D
    var animationFrames: Int?
}

struct LibraryObjectUpgradeData {
    var name: String
    var newMetadata: LibraryObjectMetadata
}

struct LibraryObjectArea {
    var radius: Int
    var shape: LibraryObjectRadiusShapes
}

enum LibraryObjectRadiusShapes: String, CaseIterable, Codable {
    case Square = "square"
    case Circle = "circle"
    case Kite = "kite"
}
