//
//  RangeOverlayLayer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import SpriteKit

class RangeOverlayLayer: SKNode, SceneLayer {
    private var rangeTileMapsByType: [ObjectTypes:SKTileMapNode]
    
    init(with scene: SKScene) {
        rangeTileMapsByType = [:]
        super.init()
        subscribeObservers()
        zPosition = RangeOverlayLayerZPosition
        scene.addChild(self)
    }
    
    deinit {
        unsubscribeObservers()
    }
    
    func hideAll() {
        for (_, tileMap) in rangeTileMapsByType {
            tileMap.removeFromParent()
        }
    }
    
    func hideAll(ofType type: ObjectTypes) {
        rangeTileMapsByType[type]?.removeFromParent()
    }
    
    func showAll(ofType type: ObjectTypes) {
        if let tileMap = rangeTileMapsByType[type] {
            if tileMap.parent == nil {
                addChild(tileMap)
            }
        }
    }
    
    func addRangeTiles(forType type: ObjectTypes, at coords: [GridCoordinate]) {
        for coordinate in coords {
            setTile(forType: type, at: coordinate)
        }
        
    }
    
    func removeRangeTiles(forType type: ObjectTypes, at coords: [GridCoordinate]) {
        for coordinate in coords {
            clearTile(forType: type, at: coordinate)
        }
        
    }
    
    private func getTileMap(forType type: ObjectTypes) -> SKTileMapNode {
        if rangeTileMapsByType[type] == nil {
            rangeTileMapsByType[type] = SKTileMapNode(
                tileSet: TileSetController.instance.rangeOverlayTileSet,
                columns: BackgroundColumns,
                rows: BackgroundRows,
                tileSize: CGSize(width: TileSize, height: TileSize)
            )
        }
        return rangeTileMapsByType[type]!
    }
    
    private func clearTile(forType type: ObjectTypes, at coords: GridCoordinate) {
        getTileMap(forType: type).setTileGroup(nil, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    private func setTile(forType type: ObjectTypes, at coords: GridCoordinate) {
        let tileGroup = TileSetController.instance.rangeOverlayTileSet.tileGroups.first!
        getTileMap(forType: type).setTileGroup(tileGroup, forColumn: coords.i, row: BackgroundRows - 1 - coords.j)
    }
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onShowObjectRangeChanged, callbackSelector: #selector(handleShowRangeChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onObjectSelected, callbackSelector: #selector(handleObjectSelected), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    @objc private func handleObjectSelected(_ notification: Notification) {
        guard let objectDef = notification.object as? LibraryObjectDef else { return }
        hideAll()
        showAll(ofType: objectDef.type)
    }
    
    @objc private func handleShowRangeChanged(_ notification: Notification) {
        guard let event = notification.object as? ShowObjectRangeEvent else { return }
        if event.shown {
            showAll(ofType: event.type)
        } else {
            hideAll(ofType: event.type)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
