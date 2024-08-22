//
//  SliceableModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import Foundation

// Object whose overflowing texture can be cut (like most buildings and some crops)
class SliceableModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
    }
}
