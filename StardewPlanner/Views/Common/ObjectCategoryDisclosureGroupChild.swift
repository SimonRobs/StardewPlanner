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
    
    var body: some View {
        DisclosureGroup(subCategory.rawValue, isExpanded: $isExpanded) {
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
        ObjectCategoryDisclosureGroupChild(subCategory: .Spring, objectTypes: [.Parsnip, .BlueJazz], isExpanded: .constant(true))
    }
}
