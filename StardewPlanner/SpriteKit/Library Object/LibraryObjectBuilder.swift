//
//  LibraryObjectBuilder.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectBuilder {
    
    static func buildObject(from definition: LibraryObjectDef) -> ScenePlaceable? {
        // TODO: Determine sprite size extension
        guard let objectSize = definition.metadata?.size else { return nil }
        let object = LibraryObject(ofType: definition.type, withSize: objectSize)
        
        if let area = definition.metadata?.area {
            object.addModifier(ofType: .Ranged, RangedModifier(object, area: area))
        }
        
        if definition.metadata?.hasBuildingShadow == true {
            object.addModifier(ofType: .Shadowed, ShadowedModifier(object))
        }
        
        if definition.metadata?.seasonal == true {
            object.addModifier(ofType: .Seasonal, SeasonalModifier(object))
        }
        
        return object
    }
}
