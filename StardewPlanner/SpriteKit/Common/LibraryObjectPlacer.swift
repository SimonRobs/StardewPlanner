//
//  LibraryObjectPlacer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectPlacer {
    
    let scene: SKScene
    let tileMap: FlooringTileMap
    
    private var placedObjects: [ScenePlaceable]
    
    private var selectedObjectDef: LibraryObjectDef?
    private var selectedObject: ScenePlaceable?
    
    init(in scene: SKScene, tileMap: FlooringTileMap) {
        placedObjects = []
        self.scene = scene
        self.tileMap = tileMap
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        if selectedObject == nil || selectedObject!.sprite.parent != nil { return }
        scene.addChild(selectedObject!.sprite)
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        selectedObject?.sprite.removeFromParent()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        guard let selectedObject = selectedObject else { return }
        selectedObject.setPosition(event.location)
        
        selectedObject.getOccupiedTiles().forEach { tile in
            tile.setBuildable(tileMap.isBuildable(atColumn: tile.gridCoordinates.i, row: tile.gridCoordinates.j))
        }
        
        updateSelectedSpriteTint()
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        guard let selectedObject = selectedObject else { return }
        
        if selectedObject.containsUnbuildableTiles() { return }
        
        NotificationController.instance.post(
            name: .onObjectPlaced,
            object: selectedObject.getOccupiedTiles().map{ tile in
                return selectedObject.sprite.position.add(tile.position).toGridCoordinate()
            })
        
        selectedObject.setTint(.Clear)
        
        placedObjects.append(selectedObject)
        self.selectedObject = nil
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        if selectedObject != nil { return }
        resetSelectedSprite(at: event.location)
        scene.addChild(selectedObject!.sprite)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        // TODO: Place items as soon as all tiles are buildable
        // For ranged items, place items according to their range but in a square pattern
    }
    
    func setObject(from definition: LibraryObjectDef) {
        cleanUp()
        selectedObjectDef = definition
        resetSelectedSprite()
        toggleObjectsArea(forType: selectedObject!.type)
    }
    
    func activate() {
    }
    
    func deactivate() {
        cleanUp()
    }
    
    func cleanUp() {
        if selectedObject?.sprite.parent != nil { selectedObject?.sprite.removeFromParent() }
        toggleObjectsArea(forType: nil)
        selectedObject = nil
    }
    
    private func toggleObjectsArea(forType type: ObjectTypes?) {
        if selectedObject == nil { return }
        for libraryObject in placedObjects {
            guard let rangedObject = libraryObject as? RangedDecorator else { continue }
            if type == rangedObject.type {
                rangedObject.showArea()
            } else {
                rangedObject.hideArea()
            }
        }
    }
    
    private func resetSelectedSprite(at location: CGPoint? = nil) {
        if selectedObjectDef == nil { return }
        selectedObject = LibraryObjectBuilder.buildObject(from: selectedObjectDef!)
        if location != nil { selectedObject!.setPosition(location!) }
        updateSelectedSpriteTint()
    }
    
    private func updateSelectedSpriteTint() {
        guard let selectedObject = selectedObject else { return }
        if selectedObject.containsUnbuildableTiles() {
            selectedObject.setTint(.Red)
        } else {
            selectedObject.setTint(.Green)
        }
    }
}
