//
//  OptionsPanelToolSelectButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct OptionsPanelToolSelectButton: View {
    
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let tool: FlooringTools
    
    private var isSelected: Bool {
        get {
            return tool == toolsStore.selectedToolType
        }
    }
    
    var body: some View {
        Button(action: {toolsStore.selectedToolType = tool}) {
            toolIcon
                .font(.title)
                .frame(maxWidth: .infinity, minHeight: 64)
        }
        .buttonStyle(DarkButtonStyle(isSelected: isSelected))
    }
    
    private var toolIcon: some View {
            if tool != .Bucket {
                return Image(systemName: tool.getIconName())
            } else {
                return Image(tool.getIconName())
            }
    }
}

struct OptionsPanelToolSelectButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanelToolSelectButton(tool: .Shape)
    }
}
