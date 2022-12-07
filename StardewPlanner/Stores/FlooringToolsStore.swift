//
//  FlooringToolsStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import Foundation
import SwiftUI

class FlooringToolsStore: ObservableObject {
    
    // MARK: - Shared Flooring Mode Variables
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
    
    // MARK: - Tool Options
    @Published var freeDrawToolOptions = FreeDrawToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onFreeDrawToolOptionsChanged, object: freeDrawToolOptions)
        }
    }
    
    @Published var eraserToolOptions = EraserToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onEraserToolOptionsChanged, object: eraserToolOptions)
        }
    }
    
    @Published var bucketToolOptions = BucketToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onBucketToolOptionsChanged, object: bucketToolOptions)
        }
    }
    
    @Published var eyedropperToolOptions = EyedropperToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onEyedropperToolOptionsChanged, object: eyedropperToolOptions)
        }
    }
    
    @Published var shapeToolOptions = ShapeToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onShapeToolOptionsChanged, object: shapeToolOptions)
        }
    }
    
    @Published var lineToolOptions = LineToolOptions() {
        didSet {
            NotificationController.instance.post(name: .onLineToolOptionsChanged, object: lineToolOptions)
        }
    }

}
