//
//  BrushShapeCreator.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-17.
//

import Foundation

class BrushShapeCreator {
    static func GetFlooringTiles(inShape shape: BrushShapes, ofSize size: CGFloat, centerAt center: GridCoordinate) -> [GridCoordinate] {
        switch(shape) {
        case .Square: return GetSquareTiles(ofSize: size, centerAt: center)
        case .Circle: return GetCircleTiles(ofSize: size, centerAt: center)
        }
    }
    
    private static func GetSquareTiles(ofSize size: CGFloat, centerAt center: GridCoordinate) -> [GridCoordinate] {
        var tiles: [GridCoordinate] = []
        let startOffset = Int(ceil(size / 2)) - 1
        let endOffset = Int(floor(size / 2))
        for column in (center.i - startOffset)...(center.i + endOffset) {
            for row in (center.j - startOffset)...(center.j + endOffset) {
                tiles.append(GridCoordinate(i: column, j: row))
            }
        }
        return tiles
    }
    
    private static func GetCircleTiles(ofSize size: CGFloat, centerAt center: GridCoordinate) -> [GridCoordinate] {
        // TODO: To Implement
        return []
    }
}
