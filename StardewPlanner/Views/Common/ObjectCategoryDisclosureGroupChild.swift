//
//  ObjectCategoryDisclosureGroupChild.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-09.
//

import SwiftUI

struct ObjectCategoryDisclosureGroupChild: View {
    
    let subCategory: ObjectSubCategories
    let objectTypes: [ObjectTypes]
    @Binding var isExpanded: Bool
    let titleOverride: String?
    
    var body: some View {
        DisclosureGroup(titleOverride ?? subCategory.rawValue, isExpanded: $isExpanded) {
            VStack {
                ForEach(objectTypes.sorted(), id: \.self) { type in
                    ObjectCategoryDisclosureGroupItem(type: type)
                }
            }
            .padding()
        }
        .disclosureGroupStyle(DisclosureChildStyle())
    }
}

struct ObjectCategoryDisclosureGroupChild_Previews: PreviewProvider {
    static var previews: some View {
        ObjectCategoryDisclosureGroupChild(
            subCategory: .Spring,
            objectTypes: [.Torch, .SkullBrazier],
            isExpanded: .constant(true),
            titleOverride: nil
        )
        .environmentObject(GlobalConfigurationStore())
        .environmentObject(ObjectLibraryStore())
    }
}
