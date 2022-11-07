//
//  PlannerLibrary.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class PlannerLibrary: ObservableObject {
    var objects: [LibraryObject] = [
        LibraryObject(name: "BG", iconName: "full_background_spring"),
        LibraryObject(name: "Buildings", iconName: "icon_buildings"),
        LibraryObject(name: "Crops", iconName: "icon_crops"),
        LibraryObject(name: "Cursor", iconName: "icon_cursor"),
        LibraryObject(name: "Flooring", iconName: "icon_flooring"),
        LibraryObject(name: "Furniture", iconName: "icon_furniture"),
        LibraryObject(name: "Trees", iconName: "icon_trees")
    ]
}
