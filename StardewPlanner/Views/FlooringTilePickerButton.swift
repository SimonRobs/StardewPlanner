//
//  FlooringTilePickerButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct FlooringTilePickerButton: View {
    
    @Binding var tile: TileSets
    @State private var isHovered = false
    
    var body: some View {
        Menu {
            ForEach(TileSets.allCases, id:\.self) { type in
                Button(action: { tile = type }) {
                    HStack {
                        Image("\(type.rawValue) Center Solo")
                        Text(type.rawValue)
                    }
                }
            }
        } label: {
            Button(action: {}) {
                Image("\(tile.rawValue) Center Solo")
            }
        }
        .menuStyle(.borderlessButton)
        .padding()
        .background(isHovered ? Color.lightBackground : Color.background)
        .cornerRadius(8)
        .onHover{ hovering in
            isHovered = hovering
        }
    }
}

struct FlooringTilePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        FlooringTilePickerButton(tile: .constant(.Wood))
    }
}
