//
//  LayoutBuilder.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

import SpriteKit

class LayoutBuilder {
    
    static let instance = LayoutBuilder()
    
    func loadLayout(_ fileName: String, forSeason season: Seasons) -> SKNode {
        // Parse the JSON File
        var layoutData: LayoutData
        switch LayoutData.from(localJSON: fileName) {
        case .success(let data):
            layoutData = data
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
        let layoutNode = SKNode()
        let tileSize = CGSize(width: layoutData.tilewidth, height: layoutData.tileheight)
        let outdoorTileSet = layoutData.tilesets.first!
        
        // Create the Tileset for the correct season
        var tileGroups: [SKTileGroup] = []
        for index in 0..<outdoorTileSet.tilecount {
            tileGroups.append(SKTileGroup(tileDefinition: SKTileDefinition(texture: SKTexture(imageNamed: "\(season) \(index)"))))
        }
        let tileset = SKTileSet(tileGroups: tileGroups)
        
        // Populate each layer (SKTileMapNode) with the respective tiles
        for layer in layoutData.layers {
            let tileMap = SKTileMapNode(tileSet: tileset, columns: layoutData.width, rows: layoutData.height, tileSize: tileSize)
            var col = 0, row = 0
            for tileGID in layer.data {
                let tileIndex = tileGID - outdoorTileSet.firstgid
                if tileIndex > 0 && tileIndex < tileGroups.count {
                    tileMap.setTileGroup(tileGroups[tileIndex], forColumn: col, row: tileMap.numberOfRows - row - 1)
                }
                col += 1
                if col >= layoutData.width { col = 0; row += 1 }
            }
            layoutNode.addChild(tileMap)
        }
        
        return layoutNode
    }
}
