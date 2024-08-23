//
//  SeasonalModifier.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-08-13.
//

import SpriteKit

class SeasonalModifier: LibraryObjectModifier {
    var type: ModifierTypes = .ComposedTexture
    var object: any ScenePlaceable
    
    init(_ object: ScenePlaceable) {
        self.object = object
        if let season = GlobalSceneState.instance.getStore()?.selectedSeason {
            setSeasonalTexture(season)
        }
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        guard let newSeason = notification.object as? Seasons else { return }
        setSeasonalTexture(newSeason)
    }
    
    private func setSeasonalTexture(_ season: Seasons) {
        let texture = SKTexture(imageNamed: "\(season.rawValue) \(object.type.rawValue)")
        texture.filteringMode = .nearest
        object.getSpriteInternal().texture = texture
    }
}
