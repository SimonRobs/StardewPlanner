//
//  SKViewAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SpriteKit

extension SKView {
    open override func rightMouseDown(with event: NSEvent) {
        self.scene?.rightMouseDown(with: event)
    }
    
    open override func scrollWheel(with event: NSEvent) {
        self.scene?.scrollWheel(with: event)
    }
}
