//
//  LineToolOptionsView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-06.
//

import SwiftUI

struct LineToolOptionsView: View {
    @EnvironmentObject() var toolsStore: FlooringToolsStore
    
    let minSize = LineToolOptions.MinStrokeWidth
    let maxSize = LineToolOptions.MaxStrokeWidth
    let sizeStep: CGFloat = 1
    
    var body: some View {
        VStack {
            Slider(
                value: $toolsStore.lineToolOptions.strokeWidth,
                in: minSize...maxSize,
                step: sizeStep,
                label: {
                    Text("Stroke Width").padding(.trailing)
                }, minimumValueLabel: {
                    Text("\(Int(minSize))")
                }, maximumValueLabel: {
                    Text("\(Int(maxSize))")
                })
            Picker(selection: $toolsStore.lineToolOptions.lineCap, content: {
                ForEach(LineToolOptions.LineCaps.allCases, id: \.self) { shape in
                    Image(systemName: shape.rawValue)
                        .padding()
                }
            }, label: {
                Text("Line Cap").padding(.trailing)
            })
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            
        }
        .padding()
    }
}

struct LineToolOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        LineToolOptionsView()
            .environmentObject(FlooringToolsStore())
    }
}
