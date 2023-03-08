//
//  EraserToolOptionsView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SwiftUI

struct EraserToolOptionsView: View {
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let minSize = EraserToolOptions.MinBrushSize
    let maxSize = EraserToolOptions.MaxBrushSize
    let sizeStep: CGFloat = 1
    
    var body: some View {
        VStack {
            Slider(
                value: $toolsStore.eraserToolOptions.size,
                in: minSize...maxSize,
                step: sizeStep,
                label: {
                    Text("Brush Radius").padding(.trailing)
                }, minimumValueLabel: {
                    Text("\(Int(minSize))")
                }, maximumValueLabel: {
                    Text("\(Int(maxSize))")
                })
            .padding(.bottom)
            
            
            Picker(selection: $toolsStore.eraserToolOptions.shape, content: {
                ForEach(BrushShapes.allCases, id: \.self) { shape in
                    Image(systemName: shape.rawValue)
                        .padding()
                }
            }, label: {
                Text("Brush Shape").padding(.trailing)
            })
            .pickerStyle(.segmented)
            .tint(.accentColor)
        }
        .padding()
    }
}

struct EraserToolOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EraserToolOptionsView()
            .environmentObject(FlooringToolsStore())
    }
}
