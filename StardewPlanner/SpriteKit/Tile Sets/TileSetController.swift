//
//  TileSetController.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import SpriteKit

class TileSetController {
   
    static let instance = TileSetController()
    
    public let flooringTileSet: SKTileSet
    
    private init() {
        flooringTileSet = SKTileSet(tileGroups: TileSets.allCases.map {tileDef in
            TileSetController.MakeTileGroup(named: tileDef.rawValue)
        })
    }
    
    private static func MakeTileGroupRules(for name: String) -> [SKTileGroupRule] {
        var tileGroupRules: [SKTileGroupRule] = []
        
        // Centers
        tileGroupRules.append(SKTileGroupRule(adjacency: [], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Center Solo"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyAll], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Center"))]))

        // Edges
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyUp), .adjacencyLowerLeft,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyDown),.adjacencyUpperLeft,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Down Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyLeft),.adjacencyUpperRight,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Left Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyRight),.adjacencyUpperLeft,.adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Right Edge"))]))

        // Corners
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyDown,.adjacencyRight, .adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Left Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyRight,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Left Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyLeft,.adjacencyUpperLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Right Edge"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyDown, .adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Right Edge"))]))

        // Vertical Line
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyDown], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Horizontal Upper Edges"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyDown], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Horizontal Edges"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Horizontal Lower Edges"))]))

        // Horizontal Line
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Vertical Left Edges"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Vertical Edges"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Vertical Right Edges"))]))

        // Corners with Inset
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Left Edge Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Right Edge Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyDown,.adjacencyRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Left Edge Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyDown], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Right Edge Inset"))]))

        // Edges with Inset
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyDown),.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Down Edge Left Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyDown), .adjacencyUpperLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Down Edge Right Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyLeft), .adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Left Edge Lower Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyLeft),.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Left Edge Upper Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyRight),.adjacencyUpperLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Right Edge Lower Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyRight),.adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Right Edge Upper Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyUp), .adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Edge Left Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal.subtracting(.adjacencyUp), .adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Edge Right Inset"))]))

        // Edges with Double Inset
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyRight,.adjacencyUp], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Down Edge Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyDown,.adjacencyLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Right Edge Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyUp,.adjacencyDown,.adjacencyRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Left Edge Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyLeft,.adjacencyRight,.adjacencyDown], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Edge Double Inset"))]))

        // Centres with Insets
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyAll.subtracting(.adjacencyLowerLeft)], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Left Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyAll.subtracting(.adjacencyLowerRight)], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Right Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyAll.subtracting(.adjacencyUpperLeft)], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Left Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyAll.subtracting(.adjacencyUpperRight)], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Upper Right Inset"))]))

        // Centres with Double Insets
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyLowerLeft,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyUpperLeft,.adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Right Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyUpperLeft,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Down Double Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyUpperRight,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Left Double Inset"))]))

        // Centres with Triple Insets
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyUpperRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Left Triple Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyUpperLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Lower Right Triple Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyLowerRight], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Left Triple Inset"))]))
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal,.adjacencyLowerLeft], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Up Right Triple Inset"))]))

        // Centres with Quadruple Insets
        tileGroupRules.append(SKTileGroupRule(adjacency: [.adjacencyCardinal], tileDefinitions: [SKTileDefinition(texture: SKTexture(imageNamed: "\(name) Quadruple Inset"))]))

        return tileGroupRules
    }

    private static func MakeTileGroup(named name: String) -> SKTileGroup {
        let tileGroup = SKTileGroup(rules: MakeTileGroupRules(for: name))
        tileGroup.name = name
        return tileGroup
    }
    
}
