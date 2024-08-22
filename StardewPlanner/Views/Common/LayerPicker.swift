//
//  LayerPicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct LayerPicker: View {
    @EnvironmentObject var configsStore: GlobalConfigurationStore
    
    @State private var selectedLayers: Set<ToggleableLayers> = [.BuildableOverflow, .Foreground] 
    
    var body: some View {
        SegmentedIconPicker(
            options: ToggleableLayers.allCases,
            optionToIconName: { $0.toImageName() },
            selection: $selectedLayers
        )
        .onAppear {
            configsStore.shownLayers = selectedLayers
        }
        .onChange(of: selectedLayers) { newValue in
            configsStore.shownLayers = newValue
        }
    }
}

struct LayerPicker_Previews: PreviewProvider {
    static var previews: some View {
        LayerPicker()
    }
}
