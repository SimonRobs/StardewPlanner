//
//  FlooringToolBase.protocol.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import Foundation

protocol FlooringToolBase {
    
    var type: FlooringTools { get }
    
    func deactivate()
    func activate()
    
    func mouseEntered(with event: TileMapMouseEvent)
    func mouseExited(with event: TileMapMouseEvent)
    func mouseMoved(with event: TileMapMouseEvent)
    func mouseDown(with event: TileMapMouseEvent)
    func mouseUp(with event: TileMapMouseEvent)
    func mouseDragged(with event: TileMapMouseEvent)
    
}
