//
//  NotificationAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import Foundation

extension Notification.Name {
    
    // MARK: - General Events
    static let onPlannerModeChanged = Notification.Name("Event::ModeChanged")
    
    // MARK: - Flooring Mode Events
    static let onFlooringModeToolChanged = Notification.Name("Event::FlooringMode::ToolChanged")
    
    // All Tools
    static let onFlooringToolPrimaryTileChanged = Notification.Name("Event::FlooringTool::PrimaryTileChanged")
    static let onFlooringToolSecondaryTileChanged = Notification.Name("Event::FlooringTool::SecondaryTileChanged")
    
    // Free Draw Tool
    static let onFreeDrawToolOptionsChanged = Notification.Name("Event::FreeDrawTool::OptionsChanged")
    
    
    // MARK: - Construction Mode Events
    static let onObjectSelected = Notification.Name("Event::ConstructionMode::onObjectSelected")
    
}
