//
//  FlooringTilePickerButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct FlooringTilePickerButton: View {
    
    @Binding var tile: TileSets
    
    var body: some View {
        Menu {
            ForEach(TileSets.allCases, id:\.self) { type in
                Button(action: { tile = type }) {
                    Image("\(type.rawValue) Center Solo")
                        .frame(minWidth: 48, minHeight: 48)
                }
            }
        } label: {
            Button(action: {}) {
                Image("\(tile.rawValue) Center Solo")
                    .frame(minWidth: 48, minHeight: 48)
            }
            .buttonStyle(DarkButtonStyle(isSelected: false))
        }
        .menuStyle(.borderlessButton)
    }
}

struct FlooringTilePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        FlooringTilePickerButton(tile: .constant(.Wood))
    }
}
