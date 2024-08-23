//
//  LibraryObjectPlacer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-16.
//

import SpriteKit

class LibraryObjectPlacer {
    private var selectedObjectDef: LibraryObjectDef?
    
    private let backgroundLayer: BackgroundLayer
    private let flooringLayer: FlooringLayer
    private let buildableLayer: BuildableLayer
    private let objectOverlayLayer: ObjectOverlayLayer
    private let rangeOverlayLayer: RangeOverlayLayer
    
    init() {
        backgroundLayer = LayersManager.instance.getLayer(ofType: .Background) as! BackgroundLayer
        flooringLayer = LayersManager.instance.getLayer(ofType: .Flooring) as! FlooringLayer
        buildableLayer = LayersManager.instance.getLayer(ofType: .Buildable) as! BuildableLayer
        objectOverlayLayer = LayersManager.instance.getLayer(ofType: .ObjectOverlay) as! ObjectOverlayLayer
        rangeOverlayLayer = LayersManager.instance.getLayer(ofType: .RangeOverlay) as! RangeOverlayLayer
    }
    
    func mouseEntered(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { return }
        objectOverlayLayer.showSelectedObject()
    }
    
    func mouseExited(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { return }
        objectOverlayLayer.hideSelectedObject()
    }
    
    func mouseMoved(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { 
            objectOverlayLayer.hideSelectedObject()
            return
        }
        objectOverlayLayer.showSelectedObject()
        
        updateSelectedObjectPosition(at: event.location)
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { return }
        
        guard let selectedObject = objectOverlayLayer.getSelectedObject() else { return }
        
        if selectedObject.cannotBePlaced() { return }
        
        // Add the object to the buildable layer
        buildableLayer.addObject(selectedObject)
        
        selectedObject.getOccupiedTiles().forEach { tile in
            
            let canBePlacedOnFlooring = selectedObjectDef?.metadata?.canBePlacedOnFlooring
            
            // Occupy the tiles in the background layer
            backgroundLayer.setOccupied(at: tile.gridCoordinates, to: true, allowsFlooring: canBePlacedOnFlooring)
            
            if canBePlacedOnFlooring != true {
                // Clear any occupied flooring tiles
                flooringLayer.clearTile(at: tile.gridCoordinates)
            }
        }
        
        // Add the range tiles to the range overlay layer
        if selectedObject.hasModifier(ofType: .Ranged) {
            rangeOverlayLayer.addRangeTiles(
                forType: selectedObject.type,
                at:
                    (selectedObject.getModifier(ofType: .Ranged) as! RangedModifier)
                    .getTilePositions()
                    .map{ pos in pos.toGridCoordinate() }
            )
            rangeOverlayLayer.showAll(ofType: selectedObject.type)
        }
        
        resetSelectedObject(at: event.location)
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { return }
        objectOverlayLayer.showSelectedObject()
        updateSelectedObjectPosition(at: event.location)
    }
    
    func mouseDragged(with event: TileMapMouseEvent) {
        if !backgroundLayer.contains(event.location) { return }
        // TODO: Place items as soon as all tiles are buildable
        // For ranged items, place items according to their range but in a square pattern
    }
    
    func setObject(from definition: LibraryObjectDef) {
        cleanUp()
        selectedObjectDef = definition
        resetSelectedObject()
    }
    
    func activate() {
    }
    
    func deactivate() {
        cleanUp()
    }
    
    func cleanUp() {
        rangeOverlayLayer.hideAll()
        objectOverlayLayer.hideSelectedObject()
        objectOverlayLayer.clearSelectedObject()
    }
    
    private func resetSelectedObject(at location: CGPoint? = nil) {
        if selectedObjectDef == nil { return }
        objectOverlayLayer.setSelectedObject(LibraryObjectBuilder.buildObject(from: selectedObjectDef!)!)
        if location != nil {
            objectOverlayLayer.updateSelectedObjectPosition(location!)
        }
    }
    
    private func updateSelectedObjectPosition(at location: CGPoint) {
        objectOverlayLayer.updateSelectedObjectPosition(location)
        
        objectOverlayLayer.getSelectedObjectTiles()?.forEach { tile in
            tile.setPlaceable(backgroundLayer.canBeOccupied(atColumn: tile.gridCoordinates.i, row: tile.gridCoordinates.j))
        }
        
        objectOverlayLayer.updateSelectedObjectTint()
    }
    
}
