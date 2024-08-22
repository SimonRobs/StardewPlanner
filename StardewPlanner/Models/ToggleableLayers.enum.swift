//
//  ToggleableLayers.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-21.
//

import Foundation

enum ToggleableLayers: CaseIterable, Identifiable, Codable  {
    case BuildableOverflow
    case Foreground
    var id: Self { self }
    
    func toImageName() -> String {
        switch self {
        case .BuildableOverflow: return "square.2.layers.3d.bottom.filled"
        case .Foreground: return "square.2.layers.3d.top.filled"
        }
    }
}
