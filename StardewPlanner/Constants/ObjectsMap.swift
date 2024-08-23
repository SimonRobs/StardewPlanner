//
//  ObjectsMap.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

let ObjectsMap: [ObjectCategories: [ObjectSubCategories: [ObjectTypes]]] = [
    .Crops: [
        .Spring: [
            .BlueJazz,
            .Cauliflower,
            .CoffeeBean,
            .Garlic,
            .GreenBean,
            .Kale,
            .Parsnip,
            .Potato,
            .Rhubarb,
            .Strawberry,
            .Tulip,
            .UnmilledRice
        ],
        .Summer: [
            .Blueberry,
            .CoffeeBean,
            .Corn,
            .Hops,
            .HotPepper,
            .Melon,
            .Poppy,
            .Radish,
            .RedCabbage,
            .Starfruit,
            .SummerSpangle,
            .Sunflower,
            .Tomato,
            .Wheat,
            .Pineapple,
            .TaroRoot
        ],
        .Fall: [
            .Amaranth,
            .Artichoke,
            .Beet,
            .BokChoy,
            .Corn,
            .Cranberries,
            .Eggplant,
            .FairyRose,
            .Grape,
            .Pumpkin,
            .Sunflower,
            .SweetGemBerry,
            .Wheat,
            .Yam
        ],
        .Special: [
            .AncientFruit,
            .CactusFruit,
            .Fiber,
            .TeaBush,
            .QiFruit,
            .Grass
        ],
        .Seeds: [
            .MixedSeeds,
            .WildSeeds
        ],
    ],
    .Buildings: [
        .Farming: [
            .Greenhouse,
            .Mill,
            .Silo,
            .FishPond,
            .Well
        ],
        .Housing: [
            .Barn,
            .Coop,
            .SlimeHutch,
            .Stable,
            .StoneCabin,
            .PlankCabin,
            .LogCabin,
        ],
        .Storage: [
            .Shed,
        ],
        .Obelisks: [
            .DesertObelisk,
            .EarthObelisk,
            //                .FarmObelisk, // Only on Ginger Island.
            .IslandObelisk,
            .WaterObelisk,
            .MiniObelisk
        ],
        .Special: [
            .GoldClock,
            .JunimoHut,
            .MiniShippingBin
        ],
    ],
    .Trees: [
        .Spring: [
            .ApricotTree,
            .CherryTree
        ],
        .Summer: [
            .BananaTree,
            .MangoTree,
            .OrangeTree,
            .PeachTree
        ],
        .Fall: [
            .AppleTree,
            .PomegranateTree
        ],
        .GeneralTrees: [
            .MahoganyTree,
            .MapleTree,
            .OakTree,
            .PineTree,
            .MushroomTree
        ],
    ],
    .FarmingUtilities: [
        .Miscellaneous: [
            .CrabPot,
            .GardenPot,
            .Scarecrow,
            .FarmComputer,
            .Hopper
        ],
        .Sprinklers: [
            .Sprinkler,
        ],
    ],
    .Equipment: [
        .Artisan: [
            .BeeHouse,
            .Keg
        ],
        .Processing: [
            .Cask,
            .CheesePress,
            .Loom,
            .MayonnaiseMachine,
            .OilMaker,
            .PreservesJar
        ],
        .Refining: [
            .CharcoalKiln,
            .Crystalarium,
            .Furnace,
            .LightningRod,
            .SolarPanel,
            .RecyclingMachine,
            .SeedMaker,
            .SlimeIncubator,
            .OstrichIncubator,
            .SlimeEggPress,
            .WormBin,
            .BoneMill,
            .GeodeCrusher
        ],
        .Storage: [
            .Chest,
            .StoneChest
        ],
    ],
    .Decoration: [
        .Fences: [
            .Gate,
            .WoodFence,
            .StoneFence,
            .IronFence,
            .HardwoodFence
        ],
        .Lighting: [
            .Torch,
            .Campfire,
            .WoodenBrazier,
            .StoneBrazier,
            .GoldBrazier,
            .CarvedBrazier,
            .StumpBrazier,
            .BarrelBrazier,
            .SkullBrazier,
            .MarbleBrazier,
            .WoodLampPost,
            .IronLampPost,
            .JackOLantern
        ],
        .Furniture: [
            .TubOfFlowers,
            .WickedStatue,
            .FluteBlock,
            .DrumBlock,
            .MiniJukebox
        ],
        .Signs: [
            .WoodSign,
            .StoneSign,
            .DarkSign
        ],
        .Removable: [
            .Twig,
            .LargeLog,
            .LargeStump,
            .Rock,
            .Boulder,
            .Meteorite
        ],
    ],
]
