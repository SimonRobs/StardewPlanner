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

let BuildingSizes: [ObjectTypes: BuildingSize] = [
    .Barn: BuildingSize(columns: 7, rows: 4, verticalOverflow: 2),
    .BigBarn: BuildingSize(columns: 7, rows: 4, verticalOverflow: 2),
    .DeluxeBarn: BuildingSize(columns: 7, rows: 4, verticalOverflow: 2),
    .Coop: BuildingSize(columns: 6, rows: 3, verticalOverflow: 3),
    .BigCoop: BuildingSize(columns: 6, rows: 3, verticalOverflow: 3),
    .DeluxeCoop: BuildingSize(columns: 6, rows: 3, verticalOverflow: 3),
    .SlimeHutch: BuildingSize(columns: 11, rows: 6, verticalOverflow: 3),
]
