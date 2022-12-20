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
        if size == 1 { return [center] }
        var tiles: [GridCoordinate] = []
        let radius = Int(ceil(size))
        
        for columnOffset in -radius...radius {
            for rowOffset in -radius...radius {
                if columnOffset * columnOffset + rowOffset * rowOffset <= radius * radius + 1 {
                    tiles.append(GridCoordinate(i: center.i + columnOffset, j: center.j + rowOffset))
                }
            }
        }
        
        return tiles
    }
}
