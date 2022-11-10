//
//  BuildTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import Foundation

import SpriteKit

public class BuildTool {
    
    var selectedBuilding: BuildingSprite?
    
    private var tileMap: FlooringTileMap
    private var background: BackgroundSprite
    private var scene: SKScene
    
    init(in scene: SKScene, with background: BackgroundSprite, and tileMap: FlooringTileMap) {
        self.tileMap = tileMap
        self.background = background
        self.scene = scene
    }
    
    func addNewObject(_ object: LibraryObject) {
        selectedBuilding = BuildingSprite(object.type, with: BuildingSizes[object.type]!)
        scene.addChild(selectedBuilding!)
    }
    
    func mouseEntered(with event: NSEvent) { }

    func mouseExited(with event: NSEvent) { }

    func mouseMoved(with event: NSEvent) {
        if !tileMap.contains(event.location(in: tileMap)) { return }
        guard let selectedBuilding = selectedBuilding else { return }
        let location = SnapToTile(event.location(in: scene))
        selectedBuilding.setPosition(to: location)
        if selectedBuilding.containsUnbuildableTiles() {
            selectedBuilding.setTint(.Red)
        } else {
            selectedBuilding.setTint(.Green)
        }
    }
    
    func mouseDown(with event: NSEvent) {
        if !tileMap.contains(event.location(in: tileMap)) { return }
        if selectedBuilding == nil || selectedBuilding!.containsUnbuildableTiles() { return }
        // TODO: Set the occupied tiles to unbuildable
        selectedBuilding!.setTint(.Clear)
        selectedBuilding = nil
    }
    
    func mouseUp(with event: NSEvent) {
        if !tileMap.contains(event.location(in: tileMap)) { return }
        addNewObject(LibraryObject(family: .Buildings, type: .Barn))
        // TODO: Make sure the object could actually be added before adding a new one
        let location = SnapToTile(event.location(in: scene))
        selectedBuilding?.setPosition(to: location)
    }
}
