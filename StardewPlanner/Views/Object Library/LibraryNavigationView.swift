//
//  LibraryNavigationView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryNavigationView: View {
    
    @EnvironmentObject() var objectLibrary: ObjectLibraryStore
    
    var body: some View {
        NavigationSplitView {
            LibraryNavigationViewSidebar(selectedCategory: $objectLibrary.selectedCategory)
        } content: {
            if objectLibrary.selectedCategory != nil {
                LibraryNavigationViewContent(subCategories: objectLibrary.objectsMap[objectLibrary.selectedCategory!]?.map{ $0.key }.sorted(by: {$0.rawValue < $1.rawValue}) ?? [],
                                             selectedSubCategory: $objectLibrary.selectedSubCategory)
            }
        } detail: {
            if objectLibrary.selectedSubCategory != nil {
                LibraryNavigationViewDetail(types: objectLibrary.objectsMap[objectLibrary.selectedCategory!]?[objectLibrary.selectedSubCategory!]?.sorted(by: {$0.rawValue < $1.rawValue}) ?? [],
                                            selectedType: $objectLibrary.selectedType)
            }
        }
    }
}

struct LibraryNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryNavigationView()
            .environmentObject(ObjectLibraryStore())
    }
}
