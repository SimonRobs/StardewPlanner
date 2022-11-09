//
//  StardewPlannerApp.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI

@main
struct StardewPlannerApp: App {
    
    @StateObject var objectLibrary = PlannerLibrary()
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
                .environmentObject(objectLibrary)
        }
        .windowStyle(.hiddenTitleBar)
        Settings {
            SettingsView()
        }
    }
}
