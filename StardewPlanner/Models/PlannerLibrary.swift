//
//  PlannerLibrary.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class PlannerLibrary: ObservableObject {
    var objects: [LibraryObject] = [
        // Buildings
        LibraryObject(family: .Buildings, type: .Barn),
        LibraryObject(family: .Buildings, type: .BigBarn),
        LibraryObject(family: .Buildings, type: .DeluxeBarn),
        LibraryObject(family: .Buildings, type: .Coop),
        LibraryObject(family: .Buildings, type: .BigCoop),
        LibraryObject(family: .Buildings, type: .DeluxeCoop),
        LibraryObject(family: .Buildings, type: .SlimeHutch),
        
        // Equipment
        LibraryObject(family: .Equipment, type: .Chest),
        LibraryObject(family: .Equipment, type: .StoneChest),
        LibraryObject(family: .Equipment, type: .Sprinkler),
        LibraryObject(family: .Equipment, type: .QualitySprinkler),
        LibraryObject(family: .Equipment, type: .IridiumSprinkler),
    ]
}
