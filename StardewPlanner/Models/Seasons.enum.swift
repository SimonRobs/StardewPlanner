//
//  Seasons.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

enum Seasons: String, CaseIterable, Identifiable, Codable  {
    case Spring = "Spring"
    case Summer = "Summer"
    case Fall = "Fall"
    case Winter = "Winter"
    var id: Self { self }
    
    func toImageName() -> String {
        switch self {
        case .Spring: return "camera.macro"
        case .Summer: return "sun.max.fill"
        case .Fall: return "leaf.fill"
        case .Winter: return "snowflake"
        }
    }
}
