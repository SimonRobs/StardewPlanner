//
//  ObjectOverlayLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class ObjectOverlayLayer: SKNode, SceneLayer {
    
    private var selectedObjectDef: LibraryObjectDef?
    private var selectedObject: ScenePlaceable?
    
    init(with scene: SKScene) {
        super.init()
        zPosition = ObjectOverlayLayerZPosition
        scene.addChild(self)
    }
    
    func setSelectedObject(_ object: ScenePlaceable) {
        selectedObject = object
    }
    
    func getSelectedObject() -> ScenePlaceable? {
        return selectedObject
    }
    
    func getSelectedObjectTiles() -> [LibraryObjectPlacementTileSprite]? {
        return selectedObject?.getOccupiedTiles()
    }
    
    func clearSelectedObject() {
        selectedObject = nil
    }
    
    func showSelectedObject() {
        if selectedObject == nil || selectedObject!.hasParent { return }
        addChild(selectedObject!.getSprite())
    }
    
    func hideSelectedObject() {
        selectedObject?.removeFromParent()
    }
    
    func updateSelectedObjectPosition(_ location: CGPoint) {
        guard let selectedObject = selectedObject else { return }
        selectedObject.setPosition(location)
    }
    
    func updateSelectedObjectTint() {
        guard let selectedObject = selectedObject else { return }
        if selectedObject.cannotBePlaced() {
            selectedObject.setTint(.Red)
        } else {
            selectedObject.setTint(.Green)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
