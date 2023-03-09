//
//  ListButtonStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-09.
//

import SwiftUI

struct ListButtonStyle: ButtonStyle {
    var isSelected: Bool
    @State private var isHovered = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding([.horizontal], 8)
            .padding([.vertical], 4)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.accentColor : isHovered ? Color.lighterBackground : Color.lightBackground)
            .foregroundColor(isHovered && !isSelected ? .accentColor : .white)
            .onHover{ hovering in
                isHovered = hovering
            }
    }
}
