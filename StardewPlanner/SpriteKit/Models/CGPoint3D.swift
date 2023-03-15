//
//  CGPoint3D.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import SpriteKit

struct CGPoint3D {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    
    init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}

extension CGPoint3D: Hashable, Codable {
    static func == (lhs: CGPoint3D, rhs: CGPoint3D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}
