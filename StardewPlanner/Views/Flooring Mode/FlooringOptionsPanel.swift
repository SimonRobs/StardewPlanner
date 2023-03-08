//
//  FlooringOptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct FlooringOptionsPanel: View {
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    var body: some View {
        VStack {
            Text("Flooring")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
            
            OptionsPanelToolSelect()
            
            Divider()
            
            FlooringTilePicker()
            
            Divider()
            
            ScrollView {
                switch toolsStore.selectedToolType {
                case .FreeDraw:
                    FreeDrawToolOptionsView()
                case .Eraser:
                    EraserToolOptionsView()
                case .Bucket:
                    BucketToolOptionsView()
                case .Eyedropper:
                    EyedropperToolOptionsView()
                case .Shape:
                    ShapeToolOptionsView()
                case .Line:
                    LineToolOptionsView()
                }
                
                Spacer()
            }
        }
    }
}

struct FlooringOptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        FlooringOptionsPanel()
            .frame(width: 300, height: 1024)
            .environmentObject(FlooringToolsStore())
    }
}
