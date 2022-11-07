//
//  TitleBar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct TitleBar: View {
    
    var body: some View {
        HStack(spacing: 0) {
            TitleBarButton(systemName: "cursorarrow", title:"Select Tool")
            TitleBarButton(systemName: "square.grid.3x1.below.line.grid.1x2", title:"Objects Library")
            Spacer()
            TitleBarButton(systemName: "square.and.arrow.up", title:"Export Design")
            TitleBarButton(systemName: "gear", title:"Settings")
        }
        .padding(.leading, 76)
        .background(Color.background)
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}

