//
//  FlooringTilePicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct FlooringTilePicker: View {
    
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let columnsDefinition: [GridItem] = Array(repeating: .init(.flexible(),spacing: 8, alignment: .center), count: 4)
    
    var body: some View {
        HStack {
            FlooringTilePickerButton(tile: $toolsStore.selectedPrimaryTile)
            Button(action: swapSelectedTiles) {
                Image(systemName: "arrow.left.and.right")
                    .padding()
            }
            .buttonStyle(DarkButtonStyle(isSelected: false))
            .contentShape(Rectangle())
            FlooringTilePickerButton(tile: $toolsStore.selectedSecondaryTile)
        }
        .padding(8)
        .background(Color.background)
        .cornerRadius(8)
        .padding()
    }
    
    private func swapSelectedTiles() {
        let oldPrimaryTile = toolsStore.selectedPrimaryTile
        toolsStore.selectedPrimaryTile = toolsStore.selectedSecondaryTile
        toolsStore.selectedSecondaryTile = oldPrimaryTile
    }
}

struct FlooringTilePicker_Previews: PreviewProvider {
    
    @State static var primary = TileSets.Wood
    @State static var secondary = TileSets.Stone
    
    static var previews: some View {
        VStack {
            Divider()
                .preferredColorScheme(.dark)
            
            FlooringTilePicker()
                .environmentObject(FlooringToolsStore())
            
            Divider()
                .preferredColorScheme(.dark)
        }
        .frame(width: 300, height: 300)
        .background(Color.lightBackground)
    }
}
