//
//  TitleBarButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct TitleBarButton: View {
    let systemName: String
    let title: String?
    let action: ()->Void
    
    @Environment(\.openWindow) private var openWindow
    
    @State private var hovering = false
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.title2)
        })
        .help(title ?? "")
        .buttonStyle(.borderless)
        .padding()
        .foregroundColor(hovering ? .accentColor : .white)
        .background(hovering ? Color.lightBackground : Color.background)
        .onHover { over in
            hovering = over
            if over {
                NSCursor.pointingHand.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}

struct TitleBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TitleBarButton(systemName: "cursorarrow.click.2", title: "Button Name") { }
    }
}
