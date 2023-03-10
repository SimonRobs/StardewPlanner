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
    let mode: EditorModes?
    let action: ()->Void
    
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject() var globalConfigsStore: GlobalConfigurationStore
    
    @State private var hovering = false
    
    init(systemName: String, title: String?, mode: EditorModes? = nil, action: @escaping () -> Void) {
        self.systemName = systemName
        self.title = title
        self.mode = mode
        self.action = action
    }
    
    private var isSelected: Bool {
        return mode == globalConfigsStore.editorMode
    }
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
        })
        .help(title ?? "")
        .buttonStyle(.borderless)
        .foregroundColor(hovering ? .accentColor : .white)
        .background(isSelected ? Color.background : hovering ? Color.lighterBackground : Color.lightBackground)
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
