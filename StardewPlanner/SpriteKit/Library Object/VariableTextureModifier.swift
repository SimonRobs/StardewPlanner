//
//  VariableTextureModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

class VariableTextureModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable

    init(_ object: ScenePlaceable) {
        self.object = object
        NotificationController.instance.subscribe(observer: self, name: .onObjectVariantChanged, callbackSelector: #selector(handleVariantChanged), object: nil)
    }
    
    @objc private func handleVariantChanged(_ notification: Notification) {
        // TODO: Handle changing the object's variant
        //        guard let newVariant = notification.object as? String else { return }
    }
}
