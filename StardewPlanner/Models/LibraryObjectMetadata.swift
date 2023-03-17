//
//  LibraryObjectMetadata.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

struct LibraryObjectMetadata: Hashable, Codable  {
    var size = LibraryObjectSize()
    var sizeExtension: LibraryObjectSizeExtension?
    var tints: [String]?
    var subtextures: [LibraryObjectSubtexture]?
    var variant: String?
    var previousUpgrade: ObjectTypes?
    var nextUpgrade: ObjectTypes?
    var noTexture: Bool?
    var layoutName: String?
    var seasonal: Bool?
    var area: LibraryObjectArea?
    var inWaterOnly: Bool?
    var hasBuildingShadow: Bool?
}

extension LibraryObjectMetadata {
    static let Invalid = LibraryObjectMetadata(size: LibraryObjectSize(columns: -1, rows: -1))
}

struct LibraryObjectSize: Hashable, Codable {
    var columns: Int = 1
    var rows: Int = 1
    var verticalOverflow: Int = 1
    
    static let zero = LibraryObjectSize(columns: 0, rows: 0, verticalOverflow: 0)
}

struct LibraryObjectSizeExtension: Hashable, Codable {
    var columns: Int
    var rows: Int
    var textureName: String
    var offset: CGPoint
}

struct LibraryObjectSubtexture: Hashable, Codable {
    var name: String
    var offset: CGPoint3D
    var animationFrames: Int?
}

struct LibraryObjectArea: Hashable, Codable {
    var radius: Int
    var shape: LibraryObjectRadiusShapes
}

enum LibraryObjectRadiusShapes: String, CaseIterable, Codable {
    case Square = "square"
    case Circle = "circle"
    case Kite = "kite"
}
