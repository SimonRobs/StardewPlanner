//
//  Constants.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-06.
//

import Foundation

let BUILDING_DEBUG = false

let BackgroundSize = CGSize(width: 1280, height: 1040)
let BackgroundColumns = 80
let BackgroundRows = 65
let TileSize: CGFloat = 16

let ObjectPlacementTileName = "Library Object Placement Tile"

let BackgroundLayerZPosition: CGFloat = 0
let FlooringLayerZPosition = BackgroundLayerZPosition + 1
let BuildableLayerZPosition = FlooringLayerZPosition + 1
let ForegroundLayerZPosition = BuildableLayerZPosition + CGFloat(BackgroundRows) + 1
let RangeOverlayLayerZPosition = ForegroundLayerZPosition + 1
let ObjectOverlayLayerZPosition = RangeOverlayLayerZPosition + 1
let FlooringOverlayLayerZPosition = ObjectOverlayLayerZPosition + 1

let AnimationsFPS = 8
