//
//  LibraryView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct LibraryView: View  {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject() var objectLibrary: ObjectLibraryStore
    
    @State private var searchFilter = ""
    @State private var filteredObjectTypes: [ObjectTypes] = []
    
    var body: some View {
        VStack(spacing: 0) {
            LibraryObjectFilter(filter: $searchFilter)
                .onChange(of: searchFilter) { newValue in
                    filteredObjectTypes = objectLibrary.getObjectTypes(containing: searchFilter)
                }
            
            if searchFilter.count > 0 {
                LibraryNavigationViewDetail(types: filteredObjectTypes, selectedType: $objectLibrary.selectedType)
                // TODO: Handle selecting a type from here. We have to find the category and sub-category.
            } else {
                LibraryNavigationView()
            }
        }
        .background(Color.background)
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(ObjectLibraryStore())
    }
}

