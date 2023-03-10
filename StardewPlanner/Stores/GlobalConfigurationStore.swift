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
    
    func updateEditorMode(withCategory category: ObjectCategories) {
        switch category {
        case .Crops, .Trees, .FarmingUtilities:
            editorMode = .Farming
        case .Buildings, .Equipment, .Decoration:
            editorMode = .Build
        }
    }
}
