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
    .BlueJazz: .init(tints: ["237FFF", "2896FF", "5E79FF", "6D83FF", "70CFFF", "BFE4FF"]),
    .Cauliflower: .init(),
    .CoffeeBean: .init(),
    .Garlic: .init(),
    .GreenBean: .init(),
    .Kale: .init(),
    .Parsnip: .init(),
    .Potato: .init(),
    .Rhubarb: .init(),
    .Strawberry: .init(),
    .Tulip: .init(tints: ["DFBFFF", "FF5000", "FF9EC1", "FFBAFF", "FFF600"]),
    .UnmilledRice: .init(),
    
    // Summer Crops
    .Blueberry: .init(),
    .Corn: .init(),
    .Hops: .init(),
    .HotPepper: .init(),
    .Melon: .init(),
    .Poppy: .init(tints: ["FEFEFE", "FF0000", "FFAA00"]),
    .Radish: .init(),
    .RedCabbage: .init(),
    .Starfruit: .init(),
    .SummerSpangle: .init(tints: ["00D0FF", "63FFD2", "CE5BFF", "FF00EE", "FF907A", "FFD400"]),
    .Sunflower: .init(),
    .Tomato: .init(),
    .Wheat: .init(),
    .Pineapple: .init(),
    .TaroRoot: .init(),
    
    // Fall Crops
    .Amaranth: .init(),
    .Artichoke: .init(),
    .Beet: .init(),
    .BokChoy: .init(),
    .Cranberries: .init(),
    .Eggplant: .init(),
    .FairyRose: .init(tints: ["47E3FF", "7789FF", "8C77FF", "BB00FF", "CDB2FF", "FF7F90"]),
    .Grape: .init(),
    .Pumpkin: .init(),
    .SweetGemBerry: .init(),
    .Yam: .init(),
    
    // Special Crops
    .AncientFruit: .init(),
    .CactusFruit: .init(),
    .Fiber: .init(),
    .TeaBush: .init(),
    .QiFruit: .init(),
    .Grass: .init(),
    
    // Giant Crops
    .GiantCauliflower: .init(size: .init(columns: 3, rows: 3, verticalOverflow: 0)),
    .GiantMelon: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  0)),
    .GiantPumpkin: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  0)),
    
    // Other Seeds
    .MixedSeeds: .init(),
    .WildSeeds: .init(),
    
    // MARK: - Buildings
    // Farming
    .Greenhouse: .init(
        size: .init(columns:  7, rows:  6, verticalOverflow:  3),
        sizeExtension:.init(columns: 3,rows: 2, textureName: "GREENHOUSE TILE", offset: .init(x: 0, y: 0)),
        subtextures: [.init(name: "Greenhouse Shadow", offset: .init(x: 0, y: 0, z: 0 ))],
        variant: "Greenhouse Broken"
    ),
    .Mill: .init(
        size: .init(columns:  4, rows:  2, verticalOverflow:  8),
        subtextures: [.init(name: "Mill Blades", offset: .init(x: 0, y: 0, z: 1 ), animationFrames: 10)]
    ),
    .Silo: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  8)),
    .Well: .init(size: .init(columns:  3, rows:  3, verticalOverflow:  3)),
    
    
    // Housing
    .Barn: .init(size: .init(columns:  7, rows:  4, verticalOverflow:  2), nextUpgrade: .BigBarn),
    .BigBarn: .init(size: .init(columns:  7, rows:  4, verticalOverflow:  2),previousUpgrade: .Barn, nextUpgrade: .DeluxeBarn),
    .DeluxeBarn: .init(size: .init(columns:  7, rows:  4, verticalOverflow:  2),previousUpgrade: .BigBarn),
    .Coop: .init(size: .init(columns:  6, rows:  3, verticalOverflow:  3), nextUpgrade: .BigCoop),
    .BigCoop: .init(size: .init(columns:  6, rows:  3, verticalOverflow:  3),previousUpgrade: .Coop, nextUpgrade: .DeluxeCoop),
    .DeluxeCoop: .init(size: .init(columns:  6, rows:  3, verticalOverflow:  3),previousUpgrade: .BigCoop),
    .FishPond: .init(
        size: .init(columns:  5, rows:  5, verticalOverflow:  3),
        subtextures: [
            .init(name: "Fish Pond Base", offset: .init(x: 0, y: 0, z: 0)),
            .init(name: "Fish Pond Netting Style", offset: .init(x: 0, y: 0, z: 1 )),
            .init(name: "Fish Pond Water", offset: .init(x: 0, y: 0, z: 2)),
            .init(name: "Fish Pond Water Reflection", offset: .init(x: 0, y: 0, z: 3)),
            .init(name: "Fish Pond Bucket Full", offset: .init(x: 0, y: 0, z: 4))
        ],
        noTexture: true),
    .SlimeHutch: .init(size: .init(columns:  11, rows:  6, verticalOverflow:  3), layoutName: "Slime Hutch"),
    .Stable: .init(size: .init(columns:  4, rows:  2, verticalOverflow:  4)),
    .StoneCabin: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), nextUpgrade: .StoneCabin1, layoutName: "Farm"),
    .StoneCabin1: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .StoneCabin, nextUpgrade: .StoneCabin2, layoutName: "Farm Upgrade 1"),
    .StoneCabin2: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .StoneCabin1, layoutName: "Farm Upgrade 2"),
    .PlankCabin: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4),  nextUpgrade: .PlankCabin1, layoutName: "Farm"),
    .PlankCabin1: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .PlankCabin, nextUpgrade: .PlankCabin2, layoutName: "Farm Upgrade 1"),
    .PlankCabin2: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .PlankCabin1, layoutName: "Farm Upgrade 2"),
    .LogCabin: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), nextUpgrade: .LogCabin1, layoutName: "Farm"),
    .LogCabin1: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .LogCabin, nextUpgrade: .LogCabin2, layoutName: "Farm Upgrade 1"),
    .LogCabin2: .init(size: .init(columns:  5, rows:  3, verticalOverflow:  4), previousUpgrade: .LogCabin1, layoutName: "Farm Upgrade 2"),
    
    // Storage
    .Shed: .init(size: .init(columns:  7, rows:  3, verticalOverflow:  4), nextUpgrade: .BigShed, layoutName: "Shed"),
    .BigShed: .init(size: .init(columns:  7, rows:  3, verticalOverflow:  4),previousUpgrade: .Shed, layoutName: "Big Shed"),
    
    // Obelisks
    .DesertObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  8)),
    .EarthObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  8)),
    .IslandObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  8)),
    .WaterObelisk: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  8)),
    .MiniObelisk: .init(),
    
    // Special
    .GoldClock: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  8)),
    .JunimoHut: .init(size: .init(columns:  3, rows:  2, verticalOverflow:  3), seasonal: true),
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
    .Scarecrow: .init(area: .init(radius: 8, shape: .Circle)),
    .DeluxeScarecrow: .init(area: .init(radius: 16, shape: .Circle)),
    .FarmComputer: .init(),
    .Hopper: .init(),
    
    // Sprinklers
    .Sprinkler: .init(nextUpgrade: .QualitySprinkler, area: .init(radius: 0, shape: .Square)),
    .QualitySprinkler: .init(previousUpgrade: .Sprinkler, nextUpgrade: .IridiumSprinkler,area: .init(radius: 1, shape: .Square)),
    .IridiumSprinkler: .init(previousUpgrade: .QualitySprinkler, area: .init(radius: 2, shape: .Square)),
    
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
