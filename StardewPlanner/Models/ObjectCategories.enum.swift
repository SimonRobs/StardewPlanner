//
//  ObjectCategories.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import Foundation

enum ObjectCategories: String, CaseIterable, Codable {
    case Crops = "Crops"
    case Buildings = "Buildings"
    case Trees = "Trees"
    case FarmingUtilities = "Farming Utilities"
    case Equipment = "Equipment"
    case Decoration = "Decoration"
}
