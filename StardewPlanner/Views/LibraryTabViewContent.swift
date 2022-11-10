//
//  LibraryTabViewContent.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabViewContent: View  {
    
    let items: [LibraryObject]
    let onObjectSelected: (_ object: LibraryObject?)->Void
    
    private let gridColumns: [GridItem]
    
    init(with items: [LibraryObject], _ onObjectSelected: @escaping (_ object: LibraryObject?)->Void) {
        self.items = items
        self.onObjectSelected = onObjectSelected
        var columnCount: Int
        switch items.first?.family {
        case .Buildings:
            columnCount = 3
        default:
            columnCount = 5
        }
        
        gridColumns = Array(repeating: GridItem(.flexible()), count: columnCount)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(items) { item in
                    LibraryTabViewContentItem(for: item)
                        .onTapGesture {
                            onObjectSelected(item)
                        }
                }
            }
            .padding()
        }
    }
}


struct LibraryTabViewContent_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabViewContent(with:[
            LibraryObject(family: .Equipment, type: .Chest),
            LibraryObject(family: .Equipment, type: .StoneChest),
            LibraryObject(family: .Equipment, type: .Sprinkler),
            LibraryObject(family: .Equipment, type: .QualitySprinkler),
            LibraryObject(family: .Equipment, type: .IridiumSprinkler),
        ]) { object in }
    }
}
