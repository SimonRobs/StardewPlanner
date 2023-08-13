//
//  ObjectTypes.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import Foundation

enum ObjectTypes: String, CaseIterable, Codable {
    // Spring Crops
    case BlueJazz = "Blue Jazz"
    case Cauliflower = "Cauliflower"
    case CoffeeBean = "Coffee Bean"
    case Garlic = "Garlic"
    case GreenBean = "Green Bean"
    case Kale = "Kale"
    case Parsnip = "Parsnip"
    case Potato = "Potato"
    case Rhubarb = "Rhubarb"
    case Strawberry = "Strawberry"
    case Tulip = "Tulip"
    case UnmilledRice = "Unmilled Rice"

    // Summer Crops
    case Blueberry = "Blueberry"
    case Corn = "Corn"
    case Hops = "Hops"
    case HotPepper = "Hot Pepper"
    case Melon = "Melon"
    case Poppy = "Poppy"
    case Radish = "Radish"
    case RedCabbage = "Red Cabbage"
    case Starfruit = "Starfruit"
    case SummerSpangle = "Summer Spangle"
    case Sunflower = "Sunflower"
    case Tomato = "Tomato"
    case Wheat = "Wheat"
    case Pineapple = "Pineapple"
    case TaroRoot = "Taro Root"

    // Fall Crops
    case Amaranth = "Amaranth"
    case Artichoke = "Artichoke"
    case Beet = "Beet"
    case BokChoy = "Bok Choy"
    case Cranberries = "Cranberries"
    case Eggplant = "Eggplant"
    case FairyRose = "Fairy Rose"
    case Grape = "Grape"
    case Pumpkin = "Pumpkin"
    case SweetGemBerry = "Sweet Gem Berry"
    case Yam = "Yam"

    // Special Crops
    case AncientFruit = "Ancient Fruit"
    case CactusFruit = "Cactus Fruit"
    case Fiber = "Fiber"
    case TeaBush = "Tea Bush"
    case QiFruit = "Qi Fruit"
    case Grass = "Grass"

    // Other Seeds
    case MixedSeeds = "Mixed Seeds"
    case WildSeeds = "Wild Seeds"

    // Farming
    case Greenhouse = "Greenhouse"
    case Mill = "Mill"
    case Silo = "Silo"
    case Well = "Well"

    // Housing
    case Barn = "Barn"
    case Coop = "Coop"
    case FishPond = "Fish Pond"
    case SlimeHutch = "Slime Hutch"
    case Stable = "Stable"
    case StoneCabin = "Stone Cabin"
    case PlankCabin = "Plank Cabin"
    case LogCabin = "Log Cabin"

    // Storage
    case Shed = "Shed"

    // Obelisks
    case DesertObelisk = "Desert Obelisk"
    case EarthObelisk = "Earth Obelisk"
    case IslandObelisk = "Island Obelisk"
    case WaterObelisk = "Water Obelisk"
    case MiniObelisk = "Mini Obelisk"

    // Special
    case GoldClock = "Gold Clock"
    case JunimoHut = "Junimo Hut"
    case MiniShippingBin = "Mini Shipping Bin"

    // Spring Trees
    case ApricotTree = "Apricot Tree"
    case CherryTree = "Cherry Tree"

    // Summer Trees
    case BananaTree = "Banana Tree"
    case MangoTree = "Mango Tree"
    case OrangeTree = "Orange Tree"
    case PeachTree = "Peach Tree"

    // Fall Trees
    case AppleTree = "Apple Tree"
    case PomegranateTree = "Pomegranate Tree"

    // General Trees
    case MahoganyTree = "Mahogany Tree"
    case MapleTree = "Maple Tree"
    case OakTree = "Oak Tree"
    case PineTree = "Pine Tree"
    case MushroomTree = "Mushroom Tree"

    // Miscellaneous
    case CrabPot = "Crab Pot"
    case GardenPot = "Garden Pot"
    case Scarecrow = "Scarecrow"
    case FarmComputer = "Farm Computer"
    case Hopper = "Hopper"

    // Sprinklers
    case Sprinkler = "Sprinkler"

    // Artisan
    case BeeHouse = "Bee House"
    case Keg = "Keg"

    // ProcessingMachines
    case Cask = "Cask"
    case CheesePress = "Cheese Press"
    case Loom = "Loom"
    case MayonnaiseMachine = "Mayonnaise Machine"
    case OilMaker = "Oil Maker"
    case PreservesJar = "Preserves Jar"

    // Refining
    case CharcoalKiln = "Charcoal Kiln"
    case Crystalarium = "Crystalarium"
    case Furnace = "Furnace"
    case LightningRod = "Lightning Rod"
    case SolarPanel = "Solar Panel"
    case RecyclingMachine = "Recycling Machine"
    case SeedMaker = "Seed Maker"
    case SlimeIncubator = "Slime Incubator"
    case OstrichIncubator = "Ostrich Incubator"
    case SlimeEggPress = "Slime Egg-Press"
    case Tapper = "Tapper"
    case HeavyTapper = "Heavy Tapper"
    case WormBin = "Worm Bin"
    case BoneMill = "Bone Mill"
    case GeodeCrusher = "Geode Crusher"

    // Storage
    case Chest = "Chest"
    case StoneChest = "Stone Chest"

    // Fences
    case Gate = "Gate"
    case WoodFence = "Wood Fence"
    case StoneFence = "Stone Fence"
    case IronFence = "Iron Fence"
    case HardwoodFence = "Hardwood Fence"

    // Lighting
    case Torch = "Torch"
    case Campfire = "Campfire"
    case WoodenBrazier = "Wooden Brazier"
    case StoneBrazier = "Stone Brazier"
    case GoldBrazier = "Gold Brazier"
    case CarvedBrazier = "Carved Brazier"
    case StumpBrazier = "Stump Brazier"
    case BarrelBrazier = "Barrel Brazier"
    case SkullBrazier = "Skull Brazier"
    case MarbleBrazier = "Marble Brazier"
    case WoodLampPost = "Wood Lamp Post"
    case IronLampPost = "Iron Lamp Post"
    case JackOLantern = "Jack-O-Lantern"

    // Furniture
    case TubOfFlowers = "Tub-O-Flowers"
    case WickedStatue = "Wicked Statue"
    case FluteBlock = "Flute Block"
    case DrumBlock = "Drum Block"
    case MiniJukebox = "Mini Jukebox"

    // Signs
    case WoodSign = "Wood Sign"
    case StoneSign = "Stone Sign"
    case DarkSign = "Dark Sign"

    // Removable
    case LargeLog = "Large Log"
    case LargeRock = "Large Rock"
    case LargeStump = "Large Stump"
    case Stone = "Stone"
    case Twig = "Twig"
    case Meteorite = "Meteorite"
}

extension ObjectTypes: Comparable {
    static func < (lhs: ObjectTypes, rhs: ObjectTypes) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
