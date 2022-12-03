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
    
    private var mode = EditorModes.Flooring
    
    private var flooringController: FlooringModeController!
    private var buildTool: BuildTool!
    
    override func didMove(to view: SKView) {
        subscribeObservers()
        
        cameraNode = (childNode(withName: "MainCamera") as? SKCameraNode)!
        
        farmBackground = BackgroundSprite()
        addChild(farmBackground)
        
        flooringTileMap = FlooringTileMap(on: farmBackground)
        addChild(flooringTileMap)

        buildTool = BuildTool(in: self, with: farmBackground, and: flooringTileMap)
        flooringController = FlooringModeController(in: self, tileMap: flooringTileMap)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        if view != nil {
            let trackingArea = NSTrackingArea(rect: view!.frame, options: [.activeAlways, .mouseMoved, .mouseEnteredAndExited], owner: self, userInfo: nil)
            view!.addTrackingArea(trackingArea)
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Build:
            buildTool.mouseEntered(with: mouseEvent)
        case .Flooring:
            flooringController.mouseEntered(with: mouseEvent)
        default:
            return
        }
    }

    override func mouseExited(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Build:
            buildTool.mouseExited(with: mouseEvent)
        case .Flooring:
            flooringController.mouseExited(with: mouseEvent)
        default:
            return
        }
    }

    override func mouseMoved(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Build:
            buildTool.mouseMoved(with: mouseEvent)
        case .Flooring:
            flooringController.mouseMoved(with: mouseEvent)
        default:
            return
        }
    }
    
//    private var previousLocation: CGPoint = .zero
    
    override func mouseDown(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Build:
            buildTool.mouseDown(with: mouseEvent)
        case .Flooring:
            flooringController.mouseDown(with: mouseEvent)
        default:
            return
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Build:
            buildTool.mouseUp(with: mouseEvent)
        case .Flooring:
            flooringController.mouseUp(with: mouseEvent)
        default:
            return
        }
    }

    override func mouseDragged(with event: NSEvent) {
        let mouseEvent = TileMapMouseEvent(from: event, in: self)
        switch mode {
        case .Flooring:
            flooringController.mouseDragged(with: mouseEvent)
        default:
            return
        }
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
//        case 0x31: mode = .Drag
        case 0x01:
            buildTool.cleanUp()
            mode = .Flooring
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
    
    private func subscribeObservers() {
        NotificationController.instance.subscribe(observer: self, name: .onObjectSelected, callbackSelector: #selector(handleLibraryObjectSelected), object: nil)
    }
    
    private func unsubscribeObservers() {
        NotificationController.instance.unsubscribe(observer: self)
    }
    
    @objc private func handleLibraryObjectSelected(_ notification: Notification) {
        mode = .Build
        guard let object = notification.object as? LibraryObject else { return }
        buildTool.addNewObject(object)
    }
}
