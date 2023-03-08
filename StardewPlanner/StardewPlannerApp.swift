//
//  StardewPlannerApp.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI

@main
struct StardewPlannerApp: App {
    
    @StateObject var objectLibraryStore = ObjectLibraryStore()
    @StateObject var globalConfigsStore = GlobalConfigurationStore()
    @StateObject var flooringToolsStore = FlooringToolsStore()
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
                .environmentObject(objectLibraryStore)
                .environmentObject(globalConfigsStore)
                .environmentObject(flooringToolsStore)
                .preferredColorScheme(.dark)
                .navigationTitle("Untitled*")
        }
        Settings {
            SettingsView()
        }
    }
}
