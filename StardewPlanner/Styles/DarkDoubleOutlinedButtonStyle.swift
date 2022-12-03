//
//  DarkDoubleOutlinedButtonStyle.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct DarkDoubleOutlinedButtonStyle: ButtonStyle {
    @State var isSelected: Bool
    @State private var isHovered = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(isSelected ? Color.accentColor : isHovered ? Color.lightBackground : Color.background )
            .foregroundColor(isHovered && !isSelected ? .accentColor : .white)
            .cornerRadius(8)
            .onHover{ hovering in
                isHovered = hovering
            }
    }
}
