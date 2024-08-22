//
//  LayersManager.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class LayersManager {
    
    static let instance = LayersManager()
    
    private var layers: [LayerTypes:SceneLayer] = [:]
    
    func setScene(_ scene: SKScene) {
        layers.removeAll()
        let initialSeason = Seasons.Spring
        layers[.Background] = BackgroundLayer(with: scene, forSeason: initialSeason);
        layers[.Flooring] = FlooringLayer(with: scene);
        layers[.Buildable] = BuildableLayer(with: scene);
        layers[.Foreground] = ForegroundLayer(with: scene, forSeason: initialSeason);
        layers[.RangeOverlay] = RangeOverlayLayer(with: scene);
        layers[.ObjectOverlay] = ObjectOverlayLayer(with: scene);
        layers[.FlooringOverlay] = FlooringOverlayLayer(with: scene);
    }
    
    func getLayer(ofType type: LayerTypes) -> SceneLayer {
        return layers[type]!
    }
    
    func confirmObjectPlacement(_ object: LibraryObject, at coords: GridCoordinate) {
        
    }
}
