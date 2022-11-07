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
    private var cameraNode: SKCameraNode!
    
    private var DragMode = false
    private var FlooringMode = false
    
    override func didMove(to view: SKView) {
        cameraNode = (childNode(withName: "MainCamera") as? SKCameraNode)!
        
        farmBackground = BackgroundSprite()
        addChild(farmBackground)
        
        flooringTileMap = FlooringTileMap()
        addChild(flooringTileMap)
        
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        if view != nil {
            let trackingArea = NSTrackingArea(rect: view!.frame, options: [.activeAlways, .mouseMoved, .mouseEnteredAndExited], owner: self, userInfo: nil)
            view!.addTrackingArea(trackingArea)
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        flooringTileMap.mouseEntered(with: event)
    }

    override func mouseExited(with event: NSEvent) {
        flooringTileMap.mouseExited(with: event)
    }

    override func mouseMoved(with event: NSEvent) {
        flooringTileMap.mouseMoved(with: event)
    }
    
//    private var previousLocation: CGPoint = .zero
    
    override func mouseDown(with event: NSEvent) {
        flooringTileMap.mouseDown(with: event)
//        let location = event.location(in: self)
//        previousLocation = event.location(in: self)
    }
    
    override func mouseUp(with event: NSEvent) {
        flooringTileMap.mouseUp(with: event)
    }

    override func mouseDragged(with event: NSEvent) {
        flooringTileMap.mouseDragged(with: event)
//        if !DragMode { return }
//        let location = event.location(in: self)
//        let deltaY = previousLocation.y - location.y
//        let deltaX = previousLocation.x - location.x

//        cameraNode.position.x += deltaX
//        if cameraNode.position.x + frame.size.width / 2 * cameraNode.xScale > farmBackground.frame.size.width / 2 {
//            cameraNode.position.x = farmBackground.frame.size.width / 2 - frame.size.width / 2 * cameraNode.xScale
//        } else if cameraNode.position.x - frame.size.width / 2 * cameraNode.xScale < -farmBackground.frame.size.width / 2 {
//            cameraNode.position.x = frame.size.width / 2 * cameraNode.xScale - farmBackground.frame.size.width / 2
//        }
//
//        cameraNode.position.y += deltaY
//        if cameraNode.position.y + frame.size.height / 2 * cameraNode.yScale > farmBackground.frame.size.height / 2 {
//            cameraNode.position.y = -frame.size.height / 2 * cameraNode.yScale + farmBackground.frame.size.height / 2
//        } else if cameraNode.position.y - frame.size.height / 2 * cameraNode.yScale  < -farmBackground.frame.size.height / 2 {
//            cameraNode.position.y =  frame.size.height / 2 * cameraNode.yScale - farmBackground.frame.size.height / 2
//        }
    }

    override func scrollWheel(with event: NSEvent) {
        var scale = cameraNode.yScale - event.deltaY
        if(scale < 0.1) { scale = 0.1 }
//        else if scale > 1 { scale = 1 }
        let zoomInAction = SKAction.scale(to: scale, duration: 0.1)
        cameraNode.run(zoomInAction)
    }
//
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        switch event.keyCode {
        case 0x31: DragMode = true
        case 0x30: flooringTileMap.setFlooringTile(ofType: .Stone)
        default: print("EH")
        }
    }
//
//    override func keyUp(with event: NSEvent) {
//        switch event.keyCode {
//        case 0x31: DragMode = false
//        default: print("EH")
//        }
//    }
}
