//
//  SeasonalModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

class SeasonalModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
        // TODO: Get active seasonal status and choose the right seasonal texture
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        // TODO: Handle changing the texture to reflect the new season
        //        guard let newSeason = notification.object as? Seasons else { return }
    }
}
