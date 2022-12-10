//
//  GridCoordinateAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-10.
//

import Foundation

extension GridCoordinate: Equatable {
    static func == (lhs: GridCoordinate, rhs: GridCoordinate) -> Bool {
        return lhs.i == rhs.i && lhs.j == rhs.j
    }
}
