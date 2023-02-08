//
//  SeasonPicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct SeasonPicker: View {
    
    @State private var selectedSeason: Set<Seasons> = [.Spring]
    
    var body: some View {
        SegmentedIconPicker(
            options: Seasons.allCases,
            optionToIconName: { $0.toImageName() },
            selection: $selectedSeason,
            singleSelection: true
        )
    }
}

struct SeasonPicker_Previews: PreviewProvider {
    static var previews: some View {
        SeasonPicker()
    }
}
