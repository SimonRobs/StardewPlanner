//
//  Extensions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

extension SKTileAdjacencyMask {
    public static var adjacencyCardinal: SKTileAdjacencyMask = .adjacencyUp.union(.adjacencyDown).union(.adjacencyRight).union(.adjacencyLeft)
}
