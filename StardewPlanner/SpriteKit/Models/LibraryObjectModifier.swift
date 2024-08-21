//
//  LibraryObjectModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

protocol LibraryObjectModifier {
    var type: ModifierTypes { get }
    var object: ScenePlaceable { get }
}
