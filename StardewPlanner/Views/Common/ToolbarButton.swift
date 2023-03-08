//
//  ToolbarButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct ToolbarButton: View {
    let systemName: String
    let title: String?
    let action: ()->Void
    
    @Environment(\.openWindow) private var openWindow
    
    @State private var hovering = false
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.title2)
                .frame(maxWidth: .infinity)
        })
        .help(title ?? "")
        .buttonStyle(.borderless)
        .padding()
        .foregroundColor(hovering ? .accentColor : .white)
        .background(hovering ? Color.lighterBackground : Color.lightBackground)
        .onHover { over in
            hovering = over
        }
    }
}

struct ToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarButton(systemName: "cursorarrow.click.2", title: "Button Name") { }
    }
}
