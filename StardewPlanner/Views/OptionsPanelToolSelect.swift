//
//  OptionsPanelToolSelect.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct OptionsPanelToolSelect: View {
    var body: some View {
        // Flooring Tool Select
        LazyVGrid(columns: .init(repeating: .init(.flexible(),spacing: 8, alignment: .center), count: 3), spacing: 8) {
            ForEach(FlooringTools.allCases, id: \.self) { tool in
                OptionsPanelToolSelectButton(tool: tool)
            }
        }
        .padding(8)
        .background(Color.background)
        .cornerRadius(8)
        .padding()
    }
}

struct OptionsPanelToolSelect_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanelToolSelect()
    }
}
