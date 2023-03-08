//
//  ObjectSubCategories.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import Foundation

enum ObjectSubCategories: String, CaseIterable, Codable {
    // Seasonal
    case Spring = "Spring"
    case Summer = "Summer"
    case Fall = "Fall"
    
    // Crops
    case Giant = "Giant"
    case Seeds = "Seeds"
    
    // Buildings
    case Farming = "Farming"
    case Housing = "Housing"
    case Obelisks = "Obelisks"
    case Special = "Special" // For Crops also
    
    // Trees
    case GeneralTrees = "General Trees"
    
    // FarmingUtilities
    case Miscellaneous = "Miscellaneous"
    case Sprinklers = "Sprinklers"
    
    // Equipment
    case Artisan = "Artisan"
    case Processing = "Processing"
    case Refining = "Refining"
    case Storage = "Storage"    // For Building also
    
    // Decoration
    case Fences = "Fences"
    case Lighting = "Lighting"
    case Furniture = "Furniture"
    case Signs = "Signs"
    case Removable = "Removable"
}
