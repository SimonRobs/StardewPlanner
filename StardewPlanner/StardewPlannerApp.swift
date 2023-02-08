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
    @StateObject var flooringToolsStore = FlooringToolsStore()
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
                .environmentObject(objectLibrary)
                .environmentObject(flooringToolsStore)
                .preferredColorScheme(.dark)
                .navigationTitle("Untitled*")
        }
        Settings {
            SettingsView()
        }
    }
}
