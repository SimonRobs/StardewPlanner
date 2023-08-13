//
//  ShapeProvider.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-06-17.
//

import Foundation
import simd

class ShapeProvider {
    static func getTiles(for shape: LibraryObjectRadiusShapes, with radius: Int) -> [CGPoint] {
        var tilePositions: [CGPoint] = []
        
        let filterStrategy: TileFilterStrategy
        switch shape {
        case .Square: filterStrategy = SquareFilterStrategy(with: radius)
        case .Circle: filterStrategy = CircleFilterStrategy(with: radius)
        case .Kite: filterStrategy = KiteFilterStrategy(with: radius)
        }
        
        for row in -radius...radius {
            for column in -radius...radius {
                if filterStrategy.isTileIncluded(atColumn: column, row: row) {
                    tilePositions.append(CGPoint(x: column * Int(TileSize), y: row * Int(TileSize)))
                }
            }
        }
        
        return tilePositions
    }
}

// Tile filtering strategies to simplify code
protocol TileFilterStrategy {
    var radius: Int { get }
    func isTileIncluded(atColumn column: Int, row: Int) -> Bool
}

class SquareFilterStrategy: TileFilterStrategy {
    var radius: Int
    
    init(with radius: Int) { self.radius = radius }
    
    func isTileIncluded(atColumn column: Int, row: Int) -> Bool {
        return true
    }
}

class CircleFilterStrategy: TileFilterStrategy {
    var radius: Int
    
    init(with radius: Int) { self.radius = radius }
    
    func isTileIncluded(atColumn column: Int, row: Int) -> Bool {
        let distanceFromCenter = simd_length(simd_quatd(vector: simd_double4(Double(column), Double(row), 0, 0)))
        let adjustedRadius: Double = Double(radius) + 1
        return distanceFromCenter < adjustedRadius
    }
}

class KiteFilterStrategy: TileFilterStrategy {
    var radius: Int
    
    init(with radius: Int) { self.radius = radius }
    
    func isTileIncluded(atColumn column: Int, row: Int) -> Bool {
        return abs(column) + abs(row) <= radius
    }
}
