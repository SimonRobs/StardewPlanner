//
//  LayoutBuilder.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

import SpriteKit

class LayoutBuilder {
    
    static let instance = LayoutBuilder()
    
    private var layoutData: LayoutData? = nil
    private var tileMapsBySeason: [Seasons: (SKNode, SKNode)] = [:] // First SKNode contains the background. Second contains the foreground
    
    func getBackgroundTileMap(forSeason season: Seasons) -> SKNode {
        if let tileMap = tileMapsBySeason[season] {
            return tileMap.0
        } else {
            loadTileMap(forSeason: season)
            return tileMapsBySeason[season]!.0
        }
    }
    
    func getForegroundTileMap(forSeason season: Seasons) -> SKNode {
        if let tileMap = tileMapsBySeason[season] {
            return tileMap.1
        } else {
            loadTileMap(forSeason: season)
            return tileMapsBySeason[season]!.1
        }
    }
    
    func loadLayoutData(_ fileName: String) {
        // Parse the JSON File
        switch LayoutData.from(localJSON: fileName) {
        case .success(let data):
            layoutData = data
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    private func loadTileMap(forSeason season: Seasons) {
        // TODO: Make this function async and add loading screen when loading a new Tile Map.
        guard let layoutData = self.layoutData else { fatalError("Did you forget to load the layout data?") }
        
        let tileSize = CGSize(width: layoutData.tilewidth, height: layoutData.tileheight)
        let outdoorTileSet = layoutData.tilesets.first!
        
        // Create the Tileset for the correct season
        var tileGroups: [SKTileGroup] = []
        for index in 0..<outdoorTileSet.tilecount {
            // Figure out if the tile has an animation
            let tileAnimation: [LayoutTileAnimation]? = outdoorTileSet.tiles.first(where: { tile in
                tile.id == index && tile.animation != nil && tile.animation!.count > 0
            })?.animation
            
            var tileDefinition: SKTileDefinition
            if tileAnimation != nil {
                let textures = tileAnimation!.map({ SKTexture(imageNamed: "\(season) \($0.tileid)") })
                let duration = CGFloat(tileAnimation![0].duration) / 1000 // The duration in the data is in ms, whereas SK expects it in s
                tileDefinition = SKTileDefinition(textures: textures, size: tileSize, timePerFrame: duration)
            } else {
                tileDefinition = SKTileDefinition(texture: SKTexture(imageNamed: "\(season) \(index)"))
            }
            
            tileGroups.append(SKTileGroup(tileDefinition: tileDefinition))
        }
        let tileset = SKTileSet(tileGroups: tileGroups)
        
        // Populate each layer (SKTileMapNode) with the respective tiles
        let backgroundNode = SKNode()
        let foregroundNode = SKNode()
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
            if layer.id == 1 || layer.id == 2 {
                backgroundNode.addChild(tileMap)
            } else {
                foregroundNode.addChild(tileMap)
            }
        }
        
        tileMapsBySeason[season] = (backgroundNode, foregroundNode)
    }
}
