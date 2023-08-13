//
//  FlooringToolSelectButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct FlooringToolSelectButton: View {
    
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
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 64)
        }
        .buttonStyle(DarkButtonStyle(isSelected: isSelected))
    }
    
    private var toolIcon: some View {
        let (isCustomSymbol, imageName) = tool.getImageData()
        if isCustomSymbol {
            return Image(imageName)
        } else {
            return Image(systemName: imageName)
        }
    }
}

struct FlooringToolSelectButton_Previews: PreviewProvider {
    static var previews: some View {
        FlooringToolSelectButton(tool: .Shape)
    }
}
