//
//  FlooringToolsStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import Foundation
import SwiftUI

class FlooringToolsStore: ObservableObject {
    
    @Published var selectedToolType: FlooringTools = .FreeDraw {
        didSet {
            NotificationController.instance.post(name: .onFlooringModeToolChanged, object: selectedToolType)
        }
    }
    
    @Published var selectedPrimaryTile: TileSets = .Wood {
        didSet {
            NotificationController.instance.post(name: .onFlooringToolPrimaryTileChanged, object: selectedPrimaryTile)
        }
    }
    
    @Published var selectedSecondaryTile: TileSets = .Wood {
        didSet {
            NotificationController.instance.post(name: .onFlooringToolSecondaryTileChanged, object: selectedSecondaryTile)
        }
    }
    
    @Published var freeDrawToolOptions = FreeDrawToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onFreeDrawToolOptionsChanged, object: freeDrawToolOptions)
        }
    }

}
