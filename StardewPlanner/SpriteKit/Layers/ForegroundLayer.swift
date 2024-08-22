//
//  ForegroundLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class ForegroundLayer: SKNode, SceneLayer {
    
    private var foregroundTileMap: SKNode?
    private var showingForeground: Bool
    
    init(with scene: SKScene, forSeason season: Seasons) {
        showingForeground = true
        super.init()
        changeForegroundTileMap(forSeason: season)
        subscribeObservers()
        zPosition = ForegroundLayerZPosition
        scene.addChild(self)
    }
    
    deinit {
        unsubscribeObservers()
    }
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onSeasonChanged, callbackSelector: #selector(handleSeasonChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onShownLayersChanged, callbackSelector: #selector(handleShownLayersChanged), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    private func changeForegroundTileMap(forSeason season: Seasons) {
        foregroundTileMap?.removeFromParent()
        foregroundTileMap = LayoutBuilder.instance.getForegroundTileMap(forSeason: season)
        if showingForeground {
            addChild(foregroundTileMap!)
        }
    }
    
    @objc private func handleSeasonChanged(_ notification: Notification) {
        guard let newSeason = notification.object as? Seasons else { return }
        changeForegroundTileMap(forSeason: newSeason)
    }
    
    @objc private func handleShownLayersChanged(_ notification: Notification) {
        if foregroundTileMap == nil { return }
        
        guard let shownLayers = notification.object as? Set<ToggleableLayers> else { return }
        if shownLayers.contains(.Foreground) {
            showingForeground = true
            if foregroundTileMap?.parent == nil {
                addChild(foregroundTileMap!)
            }
        } else {
            showingForeground = false
            foregroundTileMap?.removeFromParent()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
