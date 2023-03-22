//
//  ObjectCategoryDisclosureGroup.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-09.
//

import SwiftUI

struct ObjectCategoryDisclosureGroup: View {
    
    @EnvironmentObject() var libraryStore: ObjectLibraryStore
    
    let category: ObjectCategories
    let iconName: String
    
    @State private var isExpanded = false
    @State private var subCategoryKeys: [ObjectSubCategories] = []
    @State private var expandedFlags: Set<ObjectSubCategories> = []
    
    var body: some View {
        DisclosureGroup(category.rawValue, isExpanded: $isExpanded) {
            ForEach(subCategoryKeys, id: \.self) { subCategory in
                ObjectCategoryDisclosureGroupChild(
                    subCategory: subCategory,
                    objectTypes: libraryStore.getTypes(of: category, and: subCategory),
                    isExpanded: Binding<Bool>(
                        get: { expandedFlags.contains(subCategory) },
                        set: { isExpanding in
                            expandedFlags.removeAll()
                            if !isExpanding { return }
                            expandedFlags.insert(subCategory)
                        }
                    )
                )
            }
        }
        .disclosureGroupStyle(DisclosureParentStyle(iconName: iconName))
        .onAppear {
            subCategoryKeys = libraryStore.getSubCategories(of: category)
            updateExpandedStatus()
        }
        .onChange(of: libraryStore.selectedType) { newValue in
            updateExpandedStatus()
        }
    }
    
    private func updateExpandedStatus() {
        guard let selectedObject = libraryStore.selectedObject else { return }
        isExpanded = selectedObject.category == category
        expandedFlags = [selectedObject.subCategory]
    }
}

struct ObjectCategoryDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        ObjectCategoryDisclosureGroup(category: .Crops, iconName: "carrot.fill")
    }
}
