////
////  CropPlacer.swift
////  StardewPlanner
////
////  Created by Simon Robatto on 2023-03-22.
////
//
//import SpriteKit
//
//class CropPlacer {
//    
//    let scene: SKScene
//    let tileMap: FlooringTileMap
//    
//    var selectedCropDef: LibraryObjectDef?
//    var selectedCrop: LibraryCrop?
//    
//    private var startCoordinates: GridCoordinate? = nil
//    private var endCoordinates: GridCoordinate? = nil
//    
//    private var topLeftCorner: GridCoordinate? {
//        get {
//            startCoordinates == nil || endCoordinates == nil ? nil : GridCoordinate(
//                i: min(startCoordinates!.i, endCoordinates!.i),
//                j: max(startCoordinates!.j, endCoordinates!.j)
//            )
//        }
//    }
//    
//    private var bottomRightCorner: GridCoordinate? {
//        get {
//            startCoordinates == nil || endCoordinates == nil ? nil : GridCoordinate(
//                i: max(startCoordinates!.i, endCoordinates!.i),
//                j: min(startCoordinates!.j, endCoordinates!.j)
//            )
//        }
//    }
//    
//    init(in scene: SKScene, tileMap: FlooringTileMap) {
//        self.scene = scene
//        self.tileMap = tileMap
//    }
//    
//    func mouseEntered(with event: TileMapMouseEvent) {
////        if selectedSprite == nil || selectedSprite!.parent != nil { return }
////        scene.addChild(selectedSprite!)
//    }
//    
//    func mouseExited(with event: TileMapMouseEvent) {
////        selectedSprite?.removeFromParent()
//    }
//    
//    func mouseMoved(with event: TileMapMouseEvent) {
//        guard let selectedSprite = selectedSprite else { return }
//        selectedSprite.setPosition(event.location)
//        tileMap.overlay.setFlooringTile(toTileSet: .TilledDirt, forColumn: event.location.toGridCoordinate().i, row: event.location.toGridCoordinate().j)
//    }
//    
//    func mouseDown(with event: TileMapMouseEvent) {
//        startCoordinates = event.location.toGridCoordinate()
//        
//        NotificationController.instance.post(
//            name: .onObjectPlaced,
//            object: selectedSprite!.getOccupiedTiles().map{ tile in
//                return selectedSprite!.position.add(tile.position).toGridCoordinate()
//            })
//
//        selectedSprite = nil
//    }
//    
//    func mouseUp(with event: TileMapMouseEvent) {
//        if selectedSprite != nil { return }
//        if selectedCrop != nil {
//            resetSelectedSprite(at: event.location)
//        }
//        tileMap.overlay.clear()
//        guard let topLeftCorner = topLeftCorner, let bottomRightCorner = bottomRightCorner else { return }
//        for col in topLeftCorner.i ... bottomRightCorner.i {
//            for row in bottomRightCorner.j ... topLeftCorner.j {
//                    tileMap.setFlooringTile(
//                        toTileSet: .TilledDirt,
//                        forColumn: col,
//                        row: row
//                    )
//                guard let sprite = selectedSprite else { return }
//                scene.addChild(sprite)
//            }
//        }
//        startCoordinates = nil
//        endCoordinates = nil
//    }
//    
//    func mouseDragged(with event: TileMapMouseEvent) {
//        if endCoordinates == event.location.toGridCoordinate() { return }
//        endCoordinates = event.location.toGridCoordinate()
//        updateOverlay()
//    }
//    
//    func setCrop(_ crop: LibraryObject) {
//        selectedCrop = crop
//        cleanUp()
//        resetSelectedSprite()
//    }
//    
//    func activate() {
//    }
//    
//    func deactivate() {
//        cleanUp()
//    }
//    
//    func cleanUp() {
//        if selectedSprite != nil { selectedSprite?.removeFromParent() }
//    }
//    
//    private func updateOverlay() {
//        tileMap.overlay.clear()
//        guard let topLeftCorner = topLeftCorner, let bottomRightCorner = bottomRightCorner else { return }
//        
//        for col in topLeftCorner.i ... bottomRightCorner.i {
//            for row in bottomRightCorner.j ... topLeftCorner.j {
//                tileMap.overlay.setFlooringTile(toTileSet: .TilledDirt, forColumn: col, row: row)
//            }
//        }
//    }
//    
//    private func resetSelectedSprite(at location: CGPoint? = nil) {
//        guard let selectedCrop = self.selectedCrop else { return }
//        
//        let cropTexture = SKTexture(imageNamed: selectedCrop.type.rawValue)
//        cropTexture.filteringMode = .nearest
//        selectedSprite = LibraryCropSprite(from: selectedCrop)
//        
//        if location != nil { selectedSprite?.setPosition(location!) }
//        scene.addChild(selectedSprite!)
//    }
//}
