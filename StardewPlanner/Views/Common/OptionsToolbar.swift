//
//  OptionsToolbar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct OptionsToolbar: View {
    var body: some View {
        HStack(spacing: 8) {
            ObjectOptions()
            Spacer()
            LayerPicker()
            Divider()
            SeasonPicker()
        }
        .padding(8)
        .background(Color.lightBackground)
        .frame(maxHeight: 64)
    }
}

struct OptionsToolbar_Previews: PreviewProvider {
    static var previews: some View {
        OptionsToolbar()
    }
}
