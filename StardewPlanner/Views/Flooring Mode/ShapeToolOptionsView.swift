//
//  ShapeToolOptionsView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SwiftUI

struct ShapeToolOptionsView: View {
    
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let minSize = ShapeToolOptions.MinStrokeWidth
    let maxSize = ShapeToolOptions.MaxStrokeWidth
    let sizeStep: CGFloat = 1
    
    var body: some View {
        VStack {
            Picker(selection: $toolsStore.shapeToolOptions.shape, content: {
                ForEach(ShapeToolOptions.Shapes.allCases, id: \.self) { shape in
                    Image(systemName: shape.rawValue)
                        .padding()
                }
            }, label: {
                Text("Shape").padding(.trailing)
            })
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            if toolsStore.selectedSecondaryTile != .Empty {
                Slider(
                    value: $toolsStore.shapeToolOptions.strokeWidth,
                    in: minSize...maxSize,
                    step: sizeStep,
                    label: {
                        Text("Stroke Width").padding(.trailing)
                    }, minimumValueLabel: {
                        Text("\(Int(minSize))")
                    }, maximumValueLabel: {
                        Text("\(Int(maxSize))")
                    })
            }
            
        }
        .padding()
    }
}

struct ShapeToolOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeToolOptionsView()
            .environmentObject(FlooringToolsStore())
            .frame(width: 300)
    }
}
