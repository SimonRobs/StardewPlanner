//
//  ObjectLibraryStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class ObjectLibraryStore: ObservableObject {
    
    @Published var selectedCategory: ObjectCategories? = .Crops {
        didSet {
            selectedSubCategory = nil
        }
    }
    
    @Published var selectedSubCategory: ObjectSubCategories? = .Spring {
        didSet {
            selectedType = nil
        }
    }
    
    @Published var selectedType: ObjectTypes? = .Parsnip
    
    func getObjectTypes(containing value: String) -> [ObjectTypes] {
        var matchingTypes: [ObjectTypes] = []
        for category in objectsMap {
            for subCategory in category.value {
                for type in subCategory.value {
                    if type.rawValue.lowercased().contains(value.lowercased()) { matchingTypes.append(type) }
                }
            }
        }
        return matchingTypes
    }
    
    var objectsMap: [ObjectCategories: [ObjectSubCategories: [ObjectTypes]]] = [
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
                .Corn,
                .CoffeeBean,
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
            .Giant: [
                .GiantCauliflower,
                .GiantMelon,
                .GiantPumpkin
            ],
            .Seeds: [
                .MixedSeeds,
                .WildSeeds
            ]
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
                .BigBarn,
                .DeluxeBarn,
                .Coop,
                .BigCoop,
                .DeluxeCoop,
                .SlimeHutch,
                .Stable,
                .StoneCabin,
                .PlankCabin,
                .LogCabin
            ],
            .Storage: [
                .Shed,
                .BigShed],
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
                .DeluxeScarecrow,
                .FarmComputer,
                .Hopper
            ],
            .Sprinklers: [
                .Sprinkler,
                .QualitySprinkler,
                .IridiumSprinkler
            ],
        ],
        .Equipment: [
            .Artisan: [
                .BeeHouse
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
                .Tapper,
                .HeavyTapper,
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
                .LargeLog,
                .LargeRock,
                .LargeStump,
                .Stone,
                .Twig,
                .Meteorite
            ],
        ],
    ]
    
//    var objects: [LibraryObject] = [
//        //MARK: - Crops
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .BlueJazz),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Cauliflower),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .CoffeeBean),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Garlic),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .GreenBean),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Kale),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Parsnip),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Potato),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Rhubarb),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Strawberry),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .Tulip),
//        LibraryObject(category: .Crops, subCategory: .Spring, type: .UnmilledRice),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Blueberry),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Corn),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Hops),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .HotPepper),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Melon),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Poppy),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Radish),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .RedCabbage),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Starfruit),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .SummerSpangle),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Sunflower),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Tomato),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Wheat),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .Pineapple),
//        LibraryObject(category: .Crops, subCategory: .Summer, type: .TaroRoot),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Amaranth),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Artichoke),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Beet),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .BokChoy),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Cranberries),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Eggplant),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .FairyRose),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Grape),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Pumpkin),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .SweetGemBerry),
//        LibraryObject(category: .Crops, subCategory: .Fall, type: .Yam),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .AncientFruit),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .CactusFruit),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .Fiber),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .TeaBush),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .QiFruit),
//        LibraryObject(category: .Crops, subCategory: .SpecialCrops, type: .Grass),
//        LibraryObject(category: .Crops, subCategory: .GiantCrops, type: .GiantCauliflower),
//        LibraryObject(category: .Crops, subCategory: .GiantCrops, type: .GiantMelon),
//        LibraryObject(category: .Crops, subCategory: .GiantCrops, type: .GiantPumpkin),
//        LibraryObject(category: .Crops, subCategory: .OtherSeeds, type: .MixedSeeds),
//        LibraryObject(category: .Crops, subCategory: .OtherSeeds, type: .WildSeeds),
//
//        //MARK: - Buildings
//        LibraryObject(category: .Buildings, subCategory: .Farming, type: .Greenhouse),
//        LibraryObject(category: .Buildings, subCategory: .Farming, type: .Mill),
//        LibraryObject(category: .Buildings, subCategory: .Farming, type: .Silo),
//        LibraryObject(category: .Buildings, subCategory: .Farming, type: .Well),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .Barn),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .BigBarn),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .DeluxeBarn),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .Coop),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .BigCoop),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .DeluxeCoop),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .FishPond),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .SlimeHutch),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .Stable),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .StoneCabin),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .PlankCabin),
//        LibraryObject(category: .Buildings, subCategory: .Housing, type: .LogCabin),
//        LibraryObject(category: .Buildings, subCategory: .Storage, type: .Shed),
//        LibraryObject(category: .Buildings, subCategory: .Storage, type: .BigShed),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .DesertObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .EarthObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .FarmObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .IslandObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .WaterObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Obelisks, type: .MiniObelisk),
//        LibraryObject(category: .Buildings, subCategory: .Special, type: .GoldClock),
//        LibraryObject(category: .Buildings, subCategory: .Special, type: .JunimoHut),
//        LibraryObject(category: .Buildings, subCategory: .Special, type: .MiniShippingBin),
//
//        //MARK: - Trees
//        LibraryObject(category: .Trees, subCategory: .Spring, type: .ApricotTree),
//        LibraryObject(category: .Trees, subCategory: .Spring, type: .CherryTree),
//        LibraryObject(category: .Trees, subCategory: .Summer, type: .BananaTree),
//        LibraryObject(category: .Trees, subCategory: .Summer, type: .MangoTree),
//        LibraryObject(category: .Trees, subCategory: .Summer, type: .OrangeTree),
//        LibraryObject(category: .Trees, subCategory: .Summer, type: .PeachTree),
//        LibraryObject(category: .Trees, subCategory: .Fall, type: .AppleTree),
//        LibraryObject(category: .Trees, subCategory: .Fall, type: .PomegranateTree),
//        LibraryObject(category: .Trees, subCategory: .GeneralTrees, type: .MahoganyTree),
//        LibraryObject(category: .Trees, subCategory: .GeneralTrees, type: .MapleTree),
//        LibraryObject(category: .Trees, subCategory: .GeneralTrees, type: .OakTree),
//        LibraryObject(category: .Trees, subCategory: .GeneralTrees, type: .PineTree),
//        LibraryObject(category: .Trees, subCategory: .GeneralTrees, type: .MushroomTree),
//
//        //MARK: - Farming Utilities
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .CrabPot),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .GardenPot),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .Scarecrow),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .DeluxeScarecrow),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .FarmComputer),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Miscellaneous, type: .Hopper),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Sprinklers, type: .Sprinkler),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Sprinklers, type: .QualitySprinkler),
//        LibraryObject(category: .FarmingUtilities, subCategory: .Sprinklers, type: .IridiumSprinkler),
//
//        //MARK: - Equipment
//        LibraryObject(category: .Equipment, subCategory: .Artisan, type: .BeeHouse),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .Cask),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .CheesePress),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .Loom),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .MayonnaiseMachine),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .OilMaker),
//        LibraryObject(category: .Equipment, subCategory: .Processing, type: .PreservesJar),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .CharcoalKiln),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .Crystalarium),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .Furnace),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .LightningRod),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .SolarPanel),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .RecyclingMachine),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .SeedMaker),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .SlimeIncubator),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .OstrichIncubator),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .SlimeEggPress),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .Tapper),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .HeavyTapper),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .WormBin),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .BoneMill),
//        LibraryObject(category: .Equipment, subCategory: .Refining, type: .GeodeCrusher),
//        LibraryObject(category: .Equipment, subCategory: .Storage, type: .Chest),
//        LibraryObject(category: .Equipment, subCategory: .Storage, type: .StoneChest),
//
//        //MARK: - Decoration
//        LibraryObject(category: .Decoration, subCategory: .Fences, type: .Gate),
//        LibraryObject(category: .Decoration, subCategory: .Fences, type: .WoodFence),
//        LibraryObject(category: .Decoration, subCategory: .Fences, type: .StoneFence),
//        LibraryObject(category: .Decoration, subCategory: .Fences, type: .IronFence),
//        LibraryObject(category: .Decoration, subCategory: .Fences, type: .HardwoodFence),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .Torch),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .Campfire),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .WoodenBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .StoneBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .GoldBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .CarvedBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .StumpBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .BarrelBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .SkullBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .MarbleBrazier),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .WoodLampPost),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .IronLampPost),
//        LibraryObject(category: .Decoration, subCategory: .Lighting, type: .JackOLantern),
//        LibraryObject(category: .Decoration, subCategory: .Furniture, type: .TubOfFlowers),
//        LibraryObject(category: .Decoration, subCategory: .Furniture, type: .WickedStatue),
//        LibraryObject(category: .Decoration, subCategory: .Furniture, type: .FluteBlock),
//        LibraryObject(category: .Decoration, subCategory: .Furniture, type: .DrumBlock),
//        LibraryObject(category: .Decoration, subCategory: .Furniture, type: .MiniJukebox),
//        LibraryObject(category: .Decoration, subCategory: .Signs, type: .WoodSign),
//        LibraryObject(category: .Decoration, subCategory: .Signs, type: .StoneSign),
//        LibraryObject(category: .Decoration, subCategory: .Signs, type: .DarkSign),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .LargeLog),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .LargeRock),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .LargeStump),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .Stone),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .Twig),
//        LibraryObject(category: .Decoration, subCategory: .Removable, type: .Meteorite)
//    ]
}
