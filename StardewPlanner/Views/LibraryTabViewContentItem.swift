//
//  LibraryTabViewContentItem.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabViewContentItem: View  {
    
    let item: LibraryObject
    
    @State private var isHovered = false
    
    init(for item: LibraryObject) {
        self.item = item
    }
    
    var body: some View {
        Image(item.iconName)
            .resizable()
            .padding()
            .aspectRatio(contentMode: .fit)
            .background(isHovered ? Color.lightBackground : Color.background)
            .onHover { hovering in
                isHovered = hovering
            }
            .draggable(item)
    }
}


struct LibraryTabViewContentItem_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabViewContentItem(for: LibraryObject(name: "Test", iconName: "Barn"))
    }
}
