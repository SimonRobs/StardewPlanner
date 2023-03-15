//
//  ObjectPlacer.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-14.
//

import Foundation

protocol ObjectPlacer {
    var selectedObject: LibraryObject? { get }
    
    func setObject(_ object: LibraryObject)
}
