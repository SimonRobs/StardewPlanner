//
//  EnterableModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

class EnterableModifier: LibraryObjectModifier { 
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
    }
}
