//
//  DisclosureChildStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct DisclosureChildStyle: DisclosureGroupStyle {
    
    @State private var isHovered = false
    
    private var backgroundColor: Color {
        return isHovered ? Color.lighterBackground : Color.lightBackground
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            Button {
                configuration.isExpanded.toggle()
            } label: {
                HStack {
                    
                    Image(systemName: configuration.isExpanded ? "chevron.down" : "chevron.right")
                        .animation(nil, value: configuration.isExpanded)
                    
                    configuration.label.foregroundColor(isHovered ? .accentColor : .white)
                    
                    Spacer()
                }
                .padding(8)
                .background(backgroundColor)
                .onHover{ hovering in
                    isHovered = hovering
                }
            }
            .buttonStyle(.borderless)
            
            if configuration.isExpanded {
                Divider()
                configuration.content
            }
        }
        .background(Color.lightBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
