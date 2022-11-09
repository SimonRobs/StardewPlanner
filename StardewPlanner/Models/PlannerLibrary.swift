//
//  PlannerLibrary.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class PlannerLibrary: ObservableObject {
    var sections: [LibrarySection] = [
        LibrarySection(name: "Buildings", objects: [
            LibraryObject(name: "Barn", iconName: "Barn"),
        ]),
        LibrarySection(name: "Crops", objects: [
            LibraryObject(name: "Barn", iconName: "Barn"),
        ]),
        LibrarySection(name: "Placeables", objects: [
            LibraryObject(name: "Barn", iconName: "Barn"),
        ]),
        LibrarySection(name: "Trees", objects: [
            LibraryObject(name: "Barn", iconName: "Barn"),
        ])
    ]
}
