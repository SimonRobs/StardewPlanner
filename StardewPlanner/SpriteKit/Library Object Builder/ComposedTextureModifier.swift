//
//  ComposedTextureModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

// Object with multiple sprites as the texture
class ComposedTextureModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
    }
    
}
