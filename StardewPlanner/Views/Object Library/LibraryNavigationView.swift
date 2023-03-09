//
//  LibraryNavigationView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryNavigationView: View {
    
    @EnvironmentObject() var objectLibrary: ObjectLibraryStore
    
    @State private var selectedCategory: ObjectCategories?
    @State private var selectedSubCategory: ObjectSubCategories?
    
    private var subCategories: [ObjectSubCategories] {
        if selectedCategory == nil { return [] }
        return objectLibrary.getSubCategories(of: selectedCategory!)
    }
    
    private var objectTypes: [ObjectTypes] {
        if selectedCategory == nil || selectedSubCategory == nil { return [] }
        return objectLibrary.getTypes(of: selectedCategory!, and: selectedSubCategory!)
    }
    
    var body: some View {
        NavigationSplitView {
            LibraryNavigationViewSidebar(selectedCategory: $selectedCategory)
        } content: {
            if selectedCategory != nil {
                LibraryNavigationViewContent(
                    subCategories: subCategories,
                    selectedSubCategory: $selectedSubCategory
                )
            }
        } detail: {
            if selectedSubCategory != nil {
                LibraryNavigationViewDetail(
                    types: objectTypes,
                    selectedType: $objectLibrary.selectedType
                )
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
