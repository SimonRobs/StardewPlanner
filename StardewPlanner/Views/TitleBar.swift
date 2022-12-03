//
//  TitleBar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct TitleBar: View {
    
    @Environment(\.isLibraryPresented) var isLibraryPresented: Binding<Bool>
    
    var body: some View {
        VStack(spacing: 0) {
            TitleBarButton(systemName: "cursorarrow", title:"Select Tool") {
                
            }
            .padding(.top, 1)
            TitleBarButton(systemName: "square.grid.3x1.below.line.grid.1x2", title:"Objects Library") {
                isLibraryPresented.wrappedValue = true
            }
            .keyboardShortcut("l", modifiers: [.shift, .command])
            Spacer()
            TitleBarButton(systemName: "square.and.arrow.up", title:"Export Design") {
                
            }
            TitleBarButton(systemName: "gear", title:"Settings") {
                
            }
        }
        .frame(maxWidth: 68)
        .padding(.top, 28)
        .background(Color.background)
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}

