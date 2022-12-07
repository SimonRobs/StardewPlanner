//
//  OptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct OptionsPanel: View {
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
        .frame(width: 256)
            .background(Color.lightBackground)
    }
}

struct OptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanel()
            .frame(width: 300, height: 1024)
            .environmentObject(FlooringToolsStore())
    }
}
