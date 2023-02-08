//
//  DisclosureParentStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct DisclosureParentStyle: DisclosureGroupStyle {
    
    private var iconName: String
    
    init(iconName: String) {
        self.iconName = iconName
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                configuration.isExpanded.toggle()
            } label: {
                HStack {
                    
                    Image(systemName: configuration.isExpanded ? "chevron.down" : "chevron.right")
                        .animation(nil, value: configuration.isExpanded)
                    
                    configuration.label.foregroundColor(.white).fontWeight(.bold).font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: iconName)
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding(8)
            }
            .buttonStyle(.borderless)
            if configuration.isExpanded {
                VStack {
                    configuration.content
                }
                .padding([.leading, .trailing, .bottom], 8)
            }
        }
        .padding(4)
        .background(Color.background.clipShape(RoundedRectangle(cornerRadius: 8)))
    }
}
