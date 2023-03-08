//
//  LayerPicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

// TODO: Move to its respective folder and rename if needed
enum TileSheetLayers: CaseIterable, Identifiable, Codable  {
    case Floor
    case Buildings
    case Overlay
    var id: Self { self }
    
    func toImageName() -> String {
        switch self {
        case .Floor: return "square.3.layers.3d.bottom.filled"
        case .Buildings: return "square.3.layers.3d.middle.filled"
        case .Overlay: return "square.3.layers.3d.top.filled"
        }
    }
}

struct LayerPicker: View {
    @State private var selectedLayers: Set<TileSheetLayers> = []
    
    var body: some View {
        SegmentedIconPicker(
            options: TileSheetLayers.allCases,
            optionToIconName: { $0.toImageName() },
            selection: $selectedLayers
        )
    }
}

struct LayerPicker_Previews: PreviewProvider {
    static var previews: some View {
        LayerPicker()
    }
}
