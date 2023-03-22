//
//  LibraryObjectPlacer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectPlacer {
    
    let scene: SKScene
    
    var selectedObject: LibraryObject?
    var selectedSprite: LibraryObjectSprite?
    
    init(in scene: SKScene) {
        self.scene = scene
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        if selectedSprite == nil || selectedSprite!.parent != nil { return }
        scene.addChild(selectedSprite!)
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        selectedSprite?.removeFromParent()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        guard let selectedSprite = selectedSprite else { return }
        selectedSprite.setPosition(event.location)
        updateSelectedSpriteTint()
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        if selectedSprite == nil || selectedSprite!.containsUnbuildableTiles() { return }
        
        NotificationController.instance.post(
            name: .onObjectPlaced,
            object: selectedSprite!.getOccupiedTiles().map{ tile in
                return selectedSprite!.position.add(tile.position).toGridCoordinate()
            })

        selectedSprite!.setTint(.Clear)
        selectedSprite = nil
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        if selectedSprite != nil { return }
        if selectedObject != nil {
            resetSelectedSprite(at: event.location)
        }
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        // TODO: Place items as soon as all tiles are buildable
        // For ranged items, place items according to their range but in a square pattern
    }
    
    func setObject(_ object: LibraryObject) {
        selectedObject = object
        cleanUp()
        resetSelectedSprite()
    }
    
    func activate() {
        toggleObjectsArea(forType: selectedObject?.type)
    }
    
    func deactivate() {
        cleanUp()
        toggleObjectsArea(forType: nil)
    }
    
    func cleanUp() {
        if selectedSprite != nil { selectedSprite?.removeFromParent() }
    }
    
    private func toggleObjectsArea(forType type: ObjectTypes?) {
        for child in scene.children {
            guard let objectSprite = child as? LibraryObjectSprite else { continue }
            if type == objectSprite.type {
                objectSprite.showArea()
            } else {
                objectSprite.hideArea()
            }
        }
    }
    
    private func resetSelectedSprite(at location: CGPoint? = nil) {
        if selectedObject == nil { return }
        selectedSprite = LibraryObjectBuilder.buildObject(selectedObject!)
        if location != nil { selectedSprite?.setPosition(location!) }
        updateSelectedSpriteTint()
        scene.addChild(selectedSprite!)
    }
    
    private func updateSelectedSpriteTint() {
        guard let selectedSprite = selectedSprite else { return }
        if selectedSprite.containsUnbuildableTiles() {
            selectedSprite.setTint(.Red)
        } else {
            selectedSprite.setTint(.Green)
        }
        
    }
}
