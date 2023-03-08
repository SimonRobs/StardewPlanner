//
//  GlobalConfigurationStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import Foundation
import SwiftUI

class GlobalConfigurationStore: ObservableObject {
    
    // MARK: - Shared Flooring Mode Variables
    @Published var editorMode: EditorModes = .Flooring {
        didSet {
            NotificationController.instance.post(name: .onEditorModeChanged, object: editorMode)
        }
    }

}
