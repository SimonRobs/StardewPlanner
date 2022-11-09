//
//  LibraryTabViewButton.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabViewButton: View  {
    
    let title: String
    let isSelected: Bool
    let action: ()->Void
    
    @State private var isHovered = false
    
    init(_ title: String, isSelected: Bool, _ action: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.accentColor : isHovered ? Color.lightBackground : Color.background)
            .onHover { hovering in
                isHovered = hovering
            }
            .onTapGesture {
                action()
            }
    }
}


struct LibraryTabViewButton_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabViewButton("Test", isSelected: false) { }
    }
}
