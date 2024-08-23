//
//  OptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct OptionsPanel: View {
    
    @EnvironmentObject() var globalConfigsStore: GlobalConfigurationStore
    
    @State private var width: CGFloat = 256
    
    @State private var interactiveAreaWidth: CGFloat = 1
    @State private var interactiveAreaFill = Color.border
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                switch globalConfigsStore.editorMode {
                case .Select: SelectOptionsPanel()
                case .Farming: FarmingOptionsPanel()
                case .Flooring: FlooringOptionsPanel()
                case .Building: BuildingOptionsPanel()
                }
                Spacer()
            }
            .frame(width: width)
            .background(Color.background)
            
            Rectangle()
                .fill(interactiveAreaFill)
                .frame(width: interactiveAreaWidth)
                .contentShape(Rectangle())
                .onHover(perform: { hovering in
                    if hovering {
                        interactiveAreaWidth = 2
                        interactiveAreaFill = Color.accentColor
                    } else {
                        interactiveAreaWidth = 1
                        interactiveAreaFill = Color.border
                    }
                })
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            width = min(max(256, width + value.translation.width), 512)
                        }
                )
        }
    }
}

struct OptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanel()
            .frame(width: 300, height: 1024)
    }
}
