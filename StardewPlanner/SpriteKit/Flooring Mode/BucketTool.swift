//
//  BucketTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class BucketTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Bucket } }
    
    private var drawOptions = BucketToolOptions()
    
    private var newTileSet: TileSets? = .Wood
    
    private let backgroundLayer: BackgroundLayer
    private let flooringLayer: FlooringLayer
    private let flooringOverlayLayer: FlooringOverlayLayer
    
    init() {
        backgroundLayer = LayersManager.instance.getLayer(ofType: .Background) as! BackgroundLayer
        flooringLayer = LayersManager.instance.getLayer(ofType: .Flooring) as! FlooringLayer
        flooringOverlayLayer = LayersManager.instance.getLayer(ofType: .FlooringOverlay) as! FlooringOverlayLayer
        
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() { }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) { }
    
    func mouseDown(with event: TileMapMouseEvent) {
        let coordinates = event.location.toGridCoordinate()
        let oldTileSet = flooringLayer.getTileSet(atColumn: coordinates.i, row: coordinates.j)
        doFloodFill(atColumn: coordinates.i, row: coordinates.j, oldTileSet: oldTileSet)
    }
    
    func mouseUp(with event: TileMapMouseEvent) { }
    
    func mouseDragged(with event: TileMapMouseEvent) { }
    
    // Adapted from https://lodev.org/cgtutor/floodfill.html#Recursive_Scanline_Floodfill_Algorithm `floodFillScanlineStack` algorithm
    private func doFloodFill(atColumn column: Int, row: Int, oldTileSet: TileSets?) {
        
        if oldTileSet == newTileSet { return }
        
        var targetColumn: Int = column
        var spanAbove: Bool, spanBelow: Bool
        
        var stack: [GridCoordinate] = []
        stack.append(GridCoordinate(i: column, j: row))
        
        while !stack.isEmpty {
            let currentCoords = stack.popLast()!
            
            targetColumn = currentCoords.i
            while (targetColumn >= 0 &&
                   flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j) == oldTileSet)
            {
                targetColumn -= 1
            }
            targetColumn += 1
            spanAbove = false
            spanBelow = false
            while (targetColumn < BackgroundColumns &&
                   flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j) == oldTileSet)
            {
                if newTileSet == nil {
                    flooringLayer.clearTile(atColumn: targetColumn, row: currentCoords.j)
                } else if backgroundLayer.canBeOccupied(atColumn: targetColumn, row: currentCoords.j) {
                    flooringLayer.setTile(toTileSet: newTileSet, forColumn: targetColumn, row: currentCoords.j)
                }
                if (!spanAbove && currentCoords.j > 0 &&
                    flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j - 1) == oldTileSet &&
                    backgroundLayer.canBeOccupied(atColumn: targetColumn, row: currentCoords.j - 1)) {
                    stack.append(GridCoordinate(i: targetColumn, j: currentCoords.j - 1))
                    spanAbove = true
                } else if (spanAbove && currentCoords.j > 0 &&
                           flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j - 1) != oldTileSet) {
                    spanAbove = false
                }
                
                if (!spanBelow && currentCoords.j < BackgroundRows - 1 &&
                    flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j + 1) == oldTileSet &&
                    backgroundLayer.canBeOccupied(atColumn: targetColumn, row: currentCoords.j + 1)) {
                    stack.append(GridCoordinate(i: targetColumn, j: currentCoords.j + 1))
                    spanBelow = true
                } else if (spanBelow && currentCoords.j < BackgroundRows - 1 &&
                           flooringLayer.getTileSet(atColumn: targetColumn, row: currentCoords.j + 1) != oldTileSet) {
                    spanBelow = false
                }
                targetColumn += 1
            }
        }
    }
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? BucketToolOptions else { return }
        drawOptions = options
    }
    
    @objc private func handlePrimaryTileChanged(_ notification: Notification) {
        guard let tileSet = notification.object as? TileSets else { return }
        newTileSet = tileSet
    }
    
    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onPrimaryTileChanged, callbackSelector: #selector(handlePrimaryTileChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onBucketToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
