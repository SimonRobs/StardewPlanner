//
//  EyedropperTool.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SpriteKit

public class EyedropperTool: FlooringToolBase {
    
    var type: FlooringTools { get { return .Eyedropper } }
    
    private var drawOptions = EyedropperToolOptions()
    
    private let flooringLayer: FlooringLayer
    private let flooringOverlayLayer: FlooringOverlayLayer
    
    init() {
        flooringLayer = LayersManager.instance.getLayer(ofType: .Flooring) as! FlooringLayer
        flooringOverlayLayer = LayersManager.instance.getLayer(ofType: .FlooringOverlay) as! FlooringOverlayLayer
        
        subscribe()
    }
    
    func activate() { }
    
    func deactivate() { }
    
    func mouseEntered(with event: TileMapMouseEvent) { }
    
    func mouseExited(with event: TileMapMouseEvent) { }
    
    func mouseMoved(with event: TileMapMouseEvent) { }
    
    func mouseDown(with event: TileMapMouseEvent) { }
    
    func mouseUp(with event: TileMapMouseEvent) { }
    
    func mouseDragged(with event: TileMapMouseEvent) { }
    
    
    @objc private func handleOptionsChanged(_ notification: Notification) {
        guard let options = notification.object as? EyedropperToolOptions else { return }
        drawOptions = options
    }
    
    private func subscribe() {
        NotificationController.instance.subscribe(observer: self, name: .onEyedropperToolOptionsChanged, callbackSelector: #selector(handleOptionsChanged), object: nil)
    }
    
    private func unsubscribe() {
        NotificationController.instance.unsubscribe(observer: self)
    }
}
