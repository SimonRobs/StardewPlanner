//
//  LibrarySection.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-08.
//

import SwiftUI

struct LibrarySection: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var objects: [LibraryObject] = []
    
}
