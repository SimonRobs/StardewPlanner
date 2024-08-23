//
//  ObjectsMetadata.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

let ObjectsMetadata: [ObjectTypes: LibraryObjectMetadata] = [
    
    // MARK: - Crops
    // Spring Crops
    .BlueJazz: .init(seasonal: true, seasons: [.Spring], tints: ["237FFF", "2896FF", "5E79FF", "6D83FF", "70CFFF", "BFE4FF"]),
    .Cauliflower: .init(seasonal: true, seasons: [.Spring], canBeGiant: true),
    .CoffeeBean: .init(seasonal: true, seasons: [.Spring, .Summer]),
    .Garlic: .init(seasonal: true, seasons: [.Spring]),
    .GreenBean: .init(seasonal: true, seasons: [.Spring]),
    .Kale: .init(seasonal: true, seasons: [.Spring]),
    .Parsnip: .init(seasonal: true, seasons: [.Spring]),
    .Potato: .init(seasonal: true, seasons: [.Spring]),
    .Rhubarb: .init(seasonal: true, seasons: [.Spring]),
    .Strawberry: .init(seasonal: true, seasons: [.Spring]),
    .Tulip: .init(seasonal: true, seasons: [.Spring], tints: ["DFBFFF", "FF5000", "FF9EC1", "FFBAFF", "FFF600"]),
    .UnmilledRice: .init(seasonal: true, seasons: [.Spring]),
    
    // Summer Crops
    .Blueberry: .init(seasonal: true, seasons: [.Summer]),
    .Corn: .init(seasonal: true, seasons: [.Summer, .Fall]),
    .Hops: .init(seasonal: true, seasons: [.Summer]),
    .HotPepper: .init(seasonal: true, seasons: [.Summer]),
    .Melon: .init(seasonal: true, seasons: [.Summer], canBeGiant: true),
    .Poppy: .init(seasonal: true, seasons: [.Summer], tints: ["FEFEFE", "FF0000", "FFAA00"]),
    .Radish: .init(seasonal: true, seasons: [.Summer]),
    .RedCabbage: .init(seasonal: true, seasons: [.Summer]),
    .Starfruit: .init(seasonal: true, seasons: [.Summer]),
    .SummerSpangle: .init(seasonal: true, seasons: [.Summer], tints: ["00D0FF", "63FFD2", "CE5BFF", "FF00EE", "FF907A", "FFD400"]),
    .Sunflower: .init(seasonal: true, seasons: [.Summer, .Fall]),
    .Tomato: .init(seasonal: true, seasons: [.Summer]),
    .Wheat: .init(seasonal: true, seasons: [.Summer, .Fall]),
    .Pineapple: .init(seasonal: true, seasons: [.Summer]),
    .TaroRoot: .init(seasonal: true, seasons: [.Summer]),
    
    // Fall Crops
    .Amaranth: .init(seasonal: true, seasons: [.Fall]),
    .Artichoke: .init(seasonal: true, seasons: [.Fall]),
    .Beet: .init(seasonal: true, seasons: [.Fall]),
    .BokChoy: .init(seasonal: true, seasons: [.Fall]),
    .Cranberries: .init(seasonal: true, seasons: [.Fall]),
    .Eggplant: .init(seasonal: true, seasons: [.Fall]),
    .FairyRose: .init(seasonal: true, seasons: [.Fall], tints: ["47E3FF", "7789FF", "8C77FF", "BB00FF", "CDB2FF", "FF7F90"]),
    .Grape: .init(seasonal: true, seasons: [.Fall]),
    .Pumpkin: .init(seasonal: true, seasons: [.Fall], canBeGiant: true),
    .SweetGemBerry: .init(seasonal: true, seasons: [.Fall]),
    .Yam: .init(seasonal: true, seasons: [.Fall]),
    
    // Special Crops
    .AncientFruit: .init(),
    .CactusFruit: .init(),
    .Fiber: .init(),
    .TeaBush: .init(),
    .QiFruit: .init(),
    .Grass: .init(seasonal: true),
    
    // Other Seeds Crops
    .MixedSeeds: .init(seasonal: true, seasons: [.Spring, .Summer, .Fall]),
    .WildSeeds: .init(),
    
    // MARK: - Buildings
    // Farming
    .Greenhouse: .init(
        size: .init(columns:  7, rows:  6, verticalOverflow:  4),
        sizeExtension:.init(columns: 3,rows: 2, textureName: "GREENHOUSE TILE", offset: .init(x: 0, y: 0)),
        subtextures: [.init(name: "Greenhouse Shadow", offset: .init(x: -0.5, y: -3, z: -1 ))],
        alternativeTextures: ["Greenhouse Broken"],
        maxPlaceable: 1
    ),
    .Mill: .init(
        size: .init(columns:  4, rows:  2, verticalOverflow:  6),
        subtextures: [.init(name: "Mill Blades", offset: .init(x: -0.5, y: 2.96, z: 1 ), animationFrames: 10)],
        hasBuildingShadow: true
    ),
    .Silo: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  5), hasBuildingShadow: true),
    .Well: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  2), hasBuildingShadow: true),
    
    
    // Housing
    .Barn: .init(
        size: .init(columns:  7, rows:  4, verticalOverflow:  3),
        upgrades: [
            .init(name: "Big Barn", newMetadata: .init(layoutName: "Big Barn")),
            .init(name: "Deluxe Barn", newMetadata: .init(layoutName: "Deluxe Barn")),
        ],
        layoutName: "Barn",
        hasBuildingShadow: true
    ),
    .Coop: .init(
        size: .init(columns:  6, rows:  3, verticalOverflow:  4),
        upgrades: [
            .init(name: "Big Coop", newMetadata: .init(layoutName: "Big Coop")),
            .init(name: "Deluxe Coop", newMetadata: .init(layoutName: "Deluxe Coop")),
        ],
        layoutName: "Coop",
        hasBuildingShadow: true
    ),
    .FishPond: .init(
        size: .init(columns:  5, rows:  5, verticalOverflow:  1),
        subtextures: [
            .init(name: "Fish Pond Base", offset: .init(x: 0, y: 0, z: 0)),
            .init(name: "Fish Pond Netting Style", offset: .init(x: 0, y: 0, z: 1 )),
            .init(name: "Fish Pond Water", offset: .init(x: 0, y: 0, z: 2)),
            .init(name: "Fish Pond Water Reflection", offset: .init(x: 0, y: 0, z: 3)),
            .init(name: "Fish Pond Bucket Full", offset: .init(x: 0, y: 0, z: 4))
        ],
        noTexture: true,
        hasBuildingShadow: true),
    .SlimeHutch: .init(
        size: .init(columns:  11, rows:  6, verticalOverflow:  3),
        layoutName: "Slime Hutch",
        hasBuildingShadow: true
    ),
    .Stable: .init(
        size: .init(columns:  4, rows:  2, verticalOverflow:  4),
        hasBuildingShadow: true
    ),
    .StoneCabin: .init(
        size: .init(columns:  5, rows:  3, verticalOverflow:  4),
        upgrades: [
            .init(name: "Stone Cabin Upgrade 1", newMetadata: .init(layoutName: "Farm Upgrade 1")),
            .init(name: "Stone Cabin Upgrade 2", newMetadata: .init(layoutName: "Farm Upgrade 2")),
        ],
        layoutName: "Farm",
        hasBuildingShadow: true
    ),
    .PlankCabin: .init(
        size: .init(columns:  5, rows:  3, verticalOverflow:  4),
        upgrades: [
            .init(name: "Plank Cabin Upgrade 1", newMetadata: .init(layoutName: "Farm Upgrade 1")),
            .init(name: "Plank Cabin Upgrade 2", newMetadata: .init(layoutName: "Farm Upgrade 2")),
        ],
        layoutName: "Farm",
        hasBuildingShadow: true
    ),
    .LogCabin: .init(
        size: .init(columns:  5, rows:  3, verticalOverflow:  4),
        upgrades: [
            .init(name: "Log Cabin Upgrade 1", newMetadata: .init(layoutName: "Farm Upgrade 1")),
            .init(name: "Log Cabin Upgrade 2", newMetadata: .init(layoutName: "Farm Upgrade 2")),
        ],
        layoutName: "Farm",
        hasBuildingShadow: true
    ),
    
    // Storage
    .Shed: .init(
        size: .init(columns:  7, rows:  3, verticalOverflow:  5),
        upgrades: [
            .init(name: "Big Shed", newMetadata: .init(layoutName: "Big Shed")),
        ],
        layoutName: "Shed",
        hasBuildingShadow: true
    ),
    
    // Obelisks
    .DesertObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  6), hasBuildingShadow: true, maxPlaceable: 1),
    .EarthObelisk:  .init(size: .init(columns:  3, rows:  2, verticalOverflow:  6), hasBuildingShadow: true, maxPlaceable: 1),
    .IslandObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  6), hasBuildingShadow: true, maxPlaceable: 1),
    .WaterObelisk:  .init(size: .init(columns:  3, rows:  2, verticalOverflow:  6), hasBuildingShadow: true, maxPlaceable: 1),
    .MiniObelisk: .init(maxPlaceable: 2),
    
    // Special
    .GoldClock: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  3), hasBuildingShadow: true),
    .JunimoHut: .init(
        size: .init(columns:  3, rows:  2, verticalOverflow:  2),
        area: .init(radius: 8, shape: .Square),
        hasBuildingShadow: true,
        seasonal: true
    ),
    .MiniShippingBin: .init(),
    
    // MARK: - Trees
    // Spring Trees
    .ApricotTree: .init(),
    .CherryTree: .init(),
    
    // Summer Trees
    .BananaTree: .init(),
    .MangoTree: .init(),
    .OrangeTree: .init(),
    .PeachTree: .init(),
    
    // Fall Trees
    .AppleTree: .init(),
    .PomegranateTree: .init(),
    
    // General Trees
    .MahoganyTree: .init(),
    .MapleTree: .init(),
    .OakTree: .init(),
    .PineTree: .init(),
    .MushroomTree: .init(),
    
    // MARK: - Farming Utilities
    // Miscellaneous
    .CrabPot: .init(inWaterOnly: true),
    .GardenPot: .init(),
    .Scarecrow: .init(
        upgrades: [
            .init(name: "Deluxe Scarecrow", newMetadata: .init(area: .init(radius: 16, shape: .Circle)))
        ],
        area: .init(radius: 8, shape: .Circle)
    ),
    .FarmComputer: .init(),
    .Hopper: .init(),
    
    // Sprinklers
    .Sprinkler: .init(
        size: .init(columns: 1, rows: 1, verticalOverflow: 0),
        upgrades: [
            .init(name: "Quality Sprinkler", newMetadata: .init(area: .init(radius: 1, shape: .Square))),
            .init(name: "Iridium Sprinkler", newMetadata: .init(area: .init(radius: 2, shape: .Square))),
        ],
        area: .init(radius: 1, shape: .Kite)
    ),
    
    // MARK: - Equipment
    // Artisan
    .BeeHouse: .init(area: .init(radius: 5, shape: .Kite)),
    .Keg: .init(),
    // ProcessingMachines
    .Cask: .init(),
    .CheesePress: .init(),
    .Loom: .init(),
    .MayonnaiseMachine: .init(),
    .OilMaker: .init(),
    .PreservesJar: .init(),
    
    // Refining
    .CharcoalKiln: .init(),
    .Crystalarium: .init(),
    .Furnace: .init(),
    .LightningRod: .init(),
    .SolarPanel: .init(),
    .RecyclingMachine: .init(),
    .SeedMaker: .init(),
    .SlimeIncubator: .init(),
    .OstrichIncubator: .init(),
    .SlimeEggPress: .init(),
    .Tapper: .init(),
    .HeavyTapper: .init(),
    .WormBin: .init(),
    .BoneMill: .init(),
    .GeodeCrusher: .init(),
    
    // Storage
    .Chest: .init(),
    .StoneChest: .init(),
    
    // MARK: - Decoration
    // Fences
    .Gate: .init(),
    .WoodFence: .init(),
    .StoneFence: .init(),
    .IronFence: .init(),
    .HardwoodFence: .init(),
    
    // Lighting
    .Torch: .init(),
    .Campfire: .init(),
    .WoodenBrazier: .init(),
    .StoneBrazier: .init(),
    .GoldBrazier: .init(),
    .CarvedBrazier: .init(),
    .StumpBrazier: .init(),
    .BarrelBrazier: .init(),
    .SkullBrazier: .init(),
    .MarbleBrazier: .init(),
    .WoodLampPost: .init(),
    .IronLampPost: .init(),
    .JackOLantern: .init(),
    
    // Furniture
    .TubOfFlowers: .init(),
    .WickedStatue: .init(),
    .FluteBlock: .init(),
    .DrumBlock: .init(),
    .MiniJukebox: .init(),
    
    // Signs
    .WoodSign: .init(),
    .StoneSign: .init(),
    .DarkSign: .init(),
    
    // Removable
    .LargeLog: .init(),
    .LargeRock: .init(),
    .LargeStump: .init(),
    .Stone: .init(),
    .Twig: .init(),
    .Meteorite: .init(),
]
