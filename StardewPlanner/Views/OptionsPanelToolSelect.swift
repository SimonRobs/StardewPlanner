//
//  OptionsPanelToolSelect.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct OptionsPanelToolSelect: View {
    
    private var columnDefinition = GridItem(.flexible(), spacing: 8, alignment: .center)
    
    var body: some View {
        LazyVGrid(columns: .init(repeating: columnDefinition, count: 3), spacing: 8) {
            ForEach(FlooringTools.allCases, id: \.self) { tool in
                OptionsPanelToolSelectButton(tool: tool)
            }
        }
        .padding(8)
        .background(Color.background)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.lighterBackground)
        }
        .padding()
    }
}

struct OptionsPanelToolSelect_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanelToolSelect()
    }
}
