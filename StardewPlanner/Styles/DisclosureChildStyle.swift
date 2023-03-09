//
//  DisclosureChildStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct DisclosureChildStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                configuration.isExpanded.toggle()
            } label: {
                HStack {
                    
                    Image(systemName: configuration.isExpanded ? "chevron.down" : "chevron.right")
                        .animation(nil, value: configuration.isExpanded)
                    
                    configuration.label.foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(configuration.isExpanded ? [.leading,.top,.trailing] : [.all], 8)
            }
            .buttonStyle(.borderless)
            
            if configuration.isExpanded {
                Divider()
                configuration.content
            }
        }
        .background(Color.lightBackground.clipShape(RoundedRectangle(cornerRadius: 8)))
    }
}
