//
//  BuildingSizes.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import Foundation

struct BuildingSize {
    let columns: Int
    let rows: Int
    let verticalOverflow: Int
}

let BuildingSizes: [AllBuildings: BuildingSize] = [
    .Barn: BuildingSize(columns: 7, rows: 4, verticalOverflow: 2),
]
