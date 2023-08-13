//
//  LibraryObjectDef.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct LibraryObjectDef: Identifiable {
    var id = UUID()
    var category: ObjectCategories
    var subCategory: ObjectSubCategories
    var type: ObjectTypes
    var metadata: LibraryObjectMetadata?
}
