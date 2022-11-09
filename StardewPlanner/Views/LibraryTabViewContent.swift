//
//  LibraryTabViewContent.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabViewContent: View  {
    
    let items: [LibraryObject]
    
    private let gridColumns = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(with items: [LibraryObject]) {
        self.items = items
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(items, id: \.name) { item in
                    LibraryTabViewContentItem(for: item)
                }
            }
        }
    }
}


struct LibraryTabViewContent_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabViewContent(with: [])
    }
}
