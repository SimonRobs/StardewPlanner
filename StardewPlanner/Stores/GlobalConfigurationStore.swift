//
//  GlobalConfigurationStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import Foundation
import SwiftUI

class GlobalConfigurationStore: ObservableObject {
    
    @Published var editorMode: EditorModes = .Flooring {
        didSet {
            NotificationController.instance.post(name: .onEditorModeChanged, object: editorMode)
        }
    }
    
    @Published var selectedSeason: Seasons = .Spring {
        didSet {
            NotificationController.instance.post(name: .onSeasonChanged, object: selectedSeason)
        }
    }
    
    @Published var shownLayers: Set<ToggleableLayers> = [.BuildableOverflow, .Foreground] {
        didSet {
            NotificationController.instance.post(name: .onShownLayersChanged, object: shownLayers)
        }
    }
    
    func updateEditorMode(withCategory category: ObjectCategories) {
        switch category {
        case .Crops, .Trees, .FarmingUtilities:
            if editorMode != .Farming { editorMode = .Farming }
        case .Buildings, .Equipment, .Decoration:
            if editorMode != .Building { editorMode = .Building }
        }
    }
}
