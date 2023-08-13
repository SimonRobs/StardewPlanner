//
//  SeasonalDecorator.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import Foundation

class SeasonalDecorator: LibraryObjectDecorator {
    
    override init(_ object: ScenePlaceable) {
        super.init(object)
        // TODO: Get active seasonal status and choose the right seasonal texture
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        // TODO: Handle changing the texture to reflect the new season
        //        guard let newSeason = notification.object as? Seasons else { return }
    }
}
