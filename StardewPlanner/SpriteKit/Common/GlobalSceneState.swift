//
//  GlobalSceneState.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2024-08-22.
//

import Foundation

class GlobalSceneState {
    static let instance = GlobalSceneState()
    
    private var store: GlobalConfigurationStore?
    
    func setStore(_ store: GlobalConfigurationStore) {
        self.store = store
    }
    
    func getStore() -> GlobalConfigurationStore? {
        return store
    }
}
