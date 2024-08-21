//
//  FarmScene.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-04.
//

import SpriteKit

class FarmScene: SKScene {
    
    private var farmBackground: BackgroundSprite!
    private var flooringTileMap: FlooringTileMap!
    private var rangeOverlayTileMap: RangeOverlayTileMap!
    private var cameraController: CameraController!
    
    private var mode = EditorModes.Flooring
    private var panningCamera = false
    
    // Controllers
    private var controllers: [EditorModes: Controller] = [:]
    
    private var previousMouseLocation: CGPoint?
    
    override func didMove(to view: SKView) {
        subscribeObservers()
        
        farmBackground = BackgroundSprite()
        addChild(farmBackground)
        
        flooringTileMap = FlooringTileMap(on: farmBackground)
        addChild(flooringTileMap)
        
        rangeOverlayTileMap = RangeOverlayTileMap()
        rangeOverlayTileMap.zPosition = RangeOverlayTilesZPosition
        addChild(rangeOverlayTileMap)
        
        controllers[.Farming] = FarmingModeController(in: self, tileMap: flooringTileMap, overlayTileMap: rangeOverlayTileMap)
        controllers[.Flooring]  = FlooringModeController(in: self, tileMap: flooringTileMap)
        controllers[.Building]  = BuildingModeController(in: self, tileMap: flooringTileMap, overlayTileMap: rangeOverlayTileMap)
        
        cameraController = CameraController(for: (childNode(withName: "MainCamera") as? SKCameraNode)!)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        guard let view = self.view else { return }
        let trackingArea = NSTrackingArea(rect: view.frame, options: [.activeAlways, .mouseMoved, .mouseEnteredAndExited], owner: self, userInfo: nil)
        for area in view.trackingAreas { view.removeTrackingArea(area) }
        view.addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        controllers[mode]?.mouseEntered(with: mouseEvent)
    }

    override func mouseExited(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        controllers[mode]?.mouseExited(with: mouseEvent)
    }

    override func mouseMoved(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        if !shouldPropagateMovementEvent(mouseEvent) { return }
        controllers[mode]?.mouseMoved(with: mouseEvent)
    }
    
    override func mouseDown(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        if panningCamera {
            cameraController.beginPan(at: event.location(in: self))
            return
        }
        controllers[mode]?.mouseDown(with: mouseEvent)
    }
    
    override func mouseUp(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        if panningCamera {
            cameraController.endPan()
            return
        }
        controllers[mode]?.mouseUp(with: mouseEvent)
    }

    override func mouseDragged(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        if panningCamera {
            cameraController.pan(to: event.location(in: self))
            return
        }
        if !shouldPropagateMovementEvent(mouseEvent) { return }
        controllers[mode]?.mouseDragged(with: mouseEvent)
    }

    override func scrollWheel(with event: NSEvent) {
        cameraController.scale(by: event.deltaY)
    }

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case .KeySpace: panningCamera = true
        default: print("Pressed Key: \(event.keyCode)")
        }
    }

    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case .KeySpace: panningCamera = false
        default: print("Released Key: \(event.keyCode)")
        }
    }
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onEditorModeChanged, callbackSelector: #selector(handleEditorModeChanged), object: nil)
        NotificationController.instance.subscribe(observer: self, name: .onObjectSelected, callbackSelector: #selector(handleLibraryObjectSelected), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    @objc private func handleEditorModeChanged(_ notification: Notification) {
        guard let newMode = notification.object as? EditorModes else { return }
        controllers[mode]?.deactivate()
        mode = newMode
        controllers[mode]?.activate()
    }
    
    @objc private func handleLibraryObjectSelected(_ notification: Notification) {
        guard let objectDef = notification.object as? LibraryObjectDef else { return }
        guard let objectController = controllers[mode] as? LibraryObjectHandler else { return }
        objectController.setObject(from: objectDef)
    }
    
    /// Only share mouse moved or dragged event if we hovered over a different tile.
    /// Otherwise we send thousands of useless events.
    private func shouldPropagateMovementEvent(_ event: TileMapMouseEvent) -> Bool {
        if event.location.toGridCoordinate() == previousMouseLocation?.toGridCoordinate() { return false }
        previousMouseLocation = event.location
        return true
    }
}
