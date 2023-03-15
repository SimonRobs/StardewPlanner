//
//  OptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct OptionsPanel: View {
    
    @EnvironmentObject() var globalConfigsStore: GlobalConfigurationStore
    
    var body: some View {
        VStack {
            switch globalConfigsStore.editorMode {
            case .Select: SelectOptionsPanel()
            case .Farming: FarmingOptionsPanel()
            case .Flooring: FlooringOptionsPanel()
            case .Building: BuildingOptionsPanel()
            }
            Spacer()
        }
        .frame(width: 256)
            .background(Color.background)
    }
}

struct OptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanel()
            .frame(width: 300, height: 1024)
    }
}
