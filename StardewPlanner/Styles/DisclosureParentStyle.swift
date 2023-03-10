//
//  DisclosureParentStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct DisclosureParentStyle: DisclosureGroupStyle {
    
    @State private var isHovered = false
    
    private var iconName: String
    
    private var backgroundColor: Color {
        return isHovered ? Color.lightBackground : Color.background
    }
    
    private var foregroundColor: Color {
        return isHovered ? .accentColor : .white
    }
    
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
                    
                    configuration.label
                        .foregroundColor(foregroundColor)
                        .fontWeight(.bold)
                        .font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: iconName)
                        .foregroundColor(foregroundColor)
                        .font(.title2)
                }
                .padding(8)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onHover{ hovering in
                    isHovered = hovering
                }
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
        .background(Color.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
