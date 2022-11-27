//
//  BuildTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import Foundation

import SpriteKit

public class BuildTool {
    
    var activeLibraryObject: LibraryObject?
    var selectedBuilding: BuildingSprite?
    
    private var tileMap: FlooringTileMap
    private var background: BackgroundSprite
    private var scene: SKScene
    
    init(in scene: SKScene, with background: BackgroundSprite, and tileMap: FlooringTileMap) {
        self.tileMap = tileMap
        self.background = background
        self.scene = scene
    }
    
    func addNewObject(_ object: LibraryObject, at initialPosition: CGPoint? = nil) {
        activeLibraryObject = object
        if selectedBuilding != nil { selectedBuilding?.removeFromParent() }
        selectedBuilding = BuildingSprite(object.type, with: BuildingSizes[object.type]!)
        if initialPosition != nil { selectedBuilding?.setPosition(initialPosition!) }
        updateBuildingTiles()
        scene.addChild(selectedBuilding!)
    }
    
    func mouseEntered(with event: TileMapMouseEvent) { }

    func mouseExited(with event: TileMapMouseEvent) { }

    func mouseMoved(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        guard let selectedBuilding = selectedBuilding else { return }
        selectedBuilding.setPosition(event.location)
        updateBuildingTiles()
    }
    
    func mouseDown(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        if selectedBuilding == nil || selectedBuilding!.containsUnbuildableTiles() { return }
        
        for tile in selectedBuilding!.getOccupiedTiles() {
            let positionInScene = selectedBuilding!.position.add(tile.position)
            background.setBuildableStatus(at: positionInScene.toGridCoordinate(), to: false)
            tileMap.clearFlooringTile(at: positionInScene.toGridCoordinate())
        }
        
        selectedBuilding!.setTint(.Clear)
        selectedBuilding = nil
    }
    
    func mouseUp(with event: TileMapMouseEvent) {
        if !tileMap.contains(event.location) { return }
        if selectedBuilding != nil { return }
        if activeLibraryObject != nil {
            addNewObject(activeLibraryObject!, at: event.location)
        }
    }
    
    private func updateBuildingTiles() {
        guard let selectedBuilding = selectedBuilding else { return }
        
        for tile in selectedBuilding.getOccupiedTiles() {
            let positionInScene = selectedBuilding.position.add(tile.position)
            if let bgTile = background.getTile(at: positionInScene) {
                tile.setBuildable(bgTile.buildable)
            }
        }
        
        if selectedBuilding.containsUnbuildableTiles() {
            selectedBuilding.setTint(.Red)
        } else {
            selectedBuilding.setTint(.Green)
        }
        
    }
}
