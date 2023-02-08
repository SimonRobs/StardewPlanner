//
//  Toolbar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct Toolbar: View {
    
    @Environment(\.isLibraryPresented) var isLibraryPresented: Binding<Bool>
    
    var body: some View {
        VStack(spacing: 0) {
            ToolbarButton(systemName: "cursorarrow", title:"Select Tool") { }
            ToolbarButton(systemName: "carrot.fill", title:"Farming Tool") { }
            ToolbarButton(systemName: "road.lanes", title:"Flooring Tool") { }
            ToolbarButton(systemName: "house.fill", title:"Build Tool") { }
            
            Spacer()
            ToolbarButton(systemName: "square.grid.3x1.below.line.grid.1x2", title:"Library") {
                isLibraryPresented.wrappedValue = true
            }
            .keyboardShortcut("l", modifiers: [.shift, .command])
            
            ToolbarButton(systemName: "square.and.arrow.up", title:"Export") { }
            ToolbarButton(systemName: "gear", title:"Settings") { }
        }
        .frame(maxWidth: 68)
        .background(Color.lightBackground)
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar()
    }
}

