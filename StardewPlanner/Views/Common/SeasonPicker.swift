//
//  SeasonPicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct SeasonPicker: View {
    
    @EnvironmentObject var configsStore: GlobalConfigurationStore
    
    @State private var selectedSeason: Set<Seasons> = [.Spring]
    
    var body: some View {
        SegmentedIconPicker(
            options: Seasons.allCases,
            optionToIconName: { $0.toImageName() },
            selection: $selectedSeason,
            singleSelection: true
        )
        .onAppear {
            configsStore.selectedSeason = selectedSeason.first!
        }
        .onChange(of: selectedSeason) { newValue in
            guard let season = newValue.first else { return }
            configsStore.selectedSeason = season
        }
    }
}

struct SeasonPicker_Previews: PreviewProvider {
    static var previews: some View {
        SeasonPicker()
            .environmentObject(GlobalConfigurationStore())
    }
}
