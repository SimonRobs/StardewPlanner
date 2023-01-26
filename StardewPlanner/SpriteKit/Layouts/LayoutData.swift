//
//  LayoutData.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

import Foundation

struct LayoutTileAnimation: Decodable {
    let duration: Int
    let tileid: Int
}

struct LayoutTile: Decodable {
    let id: Int
    let animation: [LayoutTileAnimation]?
}

struct LayoutTilesets: Decodable {
    let firstgid: Int
    let columns: Int
    let imageheight: Int
    let imagewidth: Int
    let margin: Int
    let spacing: Int
    let tilecount: Int
    let tileheight: Int
    let tilewidth: Int
    let tiles: [LayoutTile]
}

struct LayoutLayers: Decodable {
    let data: [Int]
    let height: Int
    let width: Int
    let id: Int
}

struct LayoutData: Decodable {
    let height: Int
    let width: Int
    let tileheight: Int
    let tilewidth: Int
    let tilesets: [LayoutTilesets]
    let layers: [LayoutLayers]
}
