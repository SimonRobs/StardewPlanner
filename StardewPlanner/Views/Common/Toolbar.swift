//
//  Toolbar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

private struct ToolbarButtonDefinition {
    let icon: String
    let title: String
    let editorMode: EditorModes
    let keyboardShortcut: KeyEquivalent
}

struct Toolbar: View {
    
    @Environment(\.isLibraryPresented) var isLibraryPresented: Binding<Bool>
    @EnvironmentObject() var globalConfigsStore: GlobalConfigurationStore
    
    private let toolbarButtons: [ToolbarButtonDefinition] = [
        .init(icon: "cursorarrow", title: "Select Tool", editorMode: .Select, keyboardShortcut: "v"),
        .init(icon: "carrot.fill", title: "Farming Tool", editorMode: .Farming, keyboardShortcut: "f"),
        .init(icon: "road.lanes", title: "Flooring Tool", editorMode: .Flooring, keyboardShortcut: "p"),
        .init(icon: "house.fill", title: "Build Tool", editorMode: .Build, keyboardShortcut: "b"),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(toolbarButtons, id: \.icon) { button in
                ToolbarButton(systemName: button.icon, title: button.title) {
                    globalConfigsStore.editorMode = button.editorMode
                }
                .keyboardShortcut(button.keyboardShortcut)
            }
            
            Spacer()
            ToolbarButton(systemName: "books.vertical.fill", title:"Library") {
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

