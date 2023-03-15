//
//  Controller.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

protocol Controller {
    func mouseEntered(with event: TileMapMouseEvent)
    func mouseExited(with event: TileMapMouseEvent)
    func mouseMoved(with event: TileMapMouseEvent)
    func mouseDown(with event: TileMapMouseEvent)
    func mouseUp(with event: TileMapMouseEvent)
    func mouseDragged(with event: TileMapMouseEvent)
}
