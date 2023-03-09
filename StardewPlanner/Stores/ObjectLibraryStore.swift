//
//  ObjectLibraryStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class ObjectLibraryStore: ObservableObject {
    
    @Published var selectedType: ObjectTypes? {
        didSet {
            sendObjectChangedNotification()
        }
    }
    
    func getSubCategories(of category: ObjectCategories) -> [ObjectSubCategories] {
        return objectsMap[category, default: [:]].map{ $0.key }.sorted()
    }
    
    func getTypes(of category: ObjectCategories, and subCategory: ObjectSubCategories) -> [ObjectTypes] {
        return objectsMap[category, default: [:]][subCategory, default: []].sorted()
    }
    
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
    
    private func sendObjectChangedNotification() {
        if selectedType == nil { return }
        
        var selectedCategory: ObjectCategories?
        var selectedSubCategory: ObjectSubCategories?
        for category in objectsMap {
            for subCategory in category.value {
                for type in subCategory.value {
                    if type == selectedType {
                        selectedCategory = category.key
                        selectedSubCategory = subCategory.key
                        break
                    }
                }
            }
        }
        let object = LibraryObject(category: selectedCategory!, subCategory: selectedSubCategory!, type: selectedType!)
        print( selectedCategory!, selectedSubCategory!, selectedType)
        NotificationController.instance.post(name: .onObjectSelected, object: object)
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
}
