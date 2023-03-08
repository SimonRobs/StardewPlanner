//
//  LibraryObject.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct LibraryObject: Identifiable, Hashable, Codable {
    var id = UUID()
    var category: ObjectCategories
    var subCategory: ObjectSubCategories
    var type: ObjectTypes
    
}

extension LibraryObject: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .plainText)
    }
}
