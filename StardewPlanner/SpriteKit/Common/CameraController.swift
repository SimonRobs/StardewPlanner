//
//  CameraController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-19.
//

import SpriteKit

class CameraController {
    
    private let cameraNode: SKCameraNode
    
    private var panAnchor: CGPoint?
    
    init(for camera: SKCameraNode) {
        self.cameraNode = camera
    }
    
    func beginPan(at location: CGPoint) {
        NSCursor.closedHand.push()
        panAnchor = location
    }
    
    func endPan() {
        NSCursor.pop()
        panAnchor = nil
    }
    
    func pan(to location: CGPoint) {
        guard let anchor = panAnchor else  { return }
        cameraNode.position.x += anchor.x - location.x
        cameraNode.position.y += anchor.y - location.y
    }
    
    func scale(by delta: CGFloat) {
        var scale = cameraNode.yScale - delta / 2
        if(scale < 0.1) { scale = 0.1 }
        let zoomInAction = SKAction.scale(to: scale, duration: 0.1)
        cameraNode.run(zoomInAction)
    }
}
