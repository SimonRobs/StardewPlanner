//
//  BuildableLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class BuildableLayer: SKNode, SceneLayer {
    private var placedObjects: [ScenePlaceable]
    
    private var areObjectsCropped: Bool
    
    init(with scene: SKScene) {
        placedObjects = []
        areObjectsCropped = false
        super.init()
        zPosition = BuildableLayerZPosition
        scene.addChild(self)
        subscribeObservers()
    }
    
    deinit {
        unsubscribeObservers()
    }
    
    func addObject(_ object: ScenePlaceable) {
        object.setTint(.Clear)
        if object.hasModifier(ofType: .Ranged) {
            (object.getModifier(ofType: .Ranged) as! RangedModifier).hideArea()
        }
        if object.hasParent {
            object.removeFromParent()
        }
        if areObjectsCropped {
            object.hideVerticalOverflow()
        }
        addChild(object.getSprite())
        placedObjects.append(object)
    }
    
    func intersectedObject(at location: CGPoint) -> ScenePlaceable? {
        for obj in placedObjects {
            if(obj.contains(location)) { return obj }
        }
        return nil
    }
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onShownLayersChanged, callbackSelector: #selector(handleShownLayersChanged), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    
    @objc private func handleShownLayersChanged(_ notification: Notification) {
        guard let shownLayers = notification.object as? Set<ToggleableLayers> else { return }
        placedObjects.forEach { object in
            if shownLayers.contains(.BuildableOverflow) {
                areObjectsCropped = false
                object.showVerticalOverflow()
            } else {
                areObjectsCropped = true
                object.hideVerticalOverflow()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
