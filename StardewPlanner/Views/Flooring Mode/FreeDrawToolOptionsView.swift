//
//  FreeDrawToolOptionsView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-03.
//

import SwiftUI

struct FreeDrawToolOptionsView: View {
    
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let minSize = FreeDrawToolOptions.MinBrushSize
    let maxSize = FreeDrawToolOptions.MaxBrushSize
    let sizeStep: CGFloat = 1
    
    var body: some View {
        VStack {
            Slider(
                value: $toolsStore.freeDrawToolOptions.size,
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
            
            
            Picker(selection: $toolsStore.freeDrawToolOptions.shape, content: {
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

struct FreeDrawToolOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        FreeDrawToolOptionsView()
            .environmentObject(FlooringToolsStore())
    }
}
