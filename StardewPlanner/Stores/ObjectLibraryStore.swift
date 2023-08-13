//
//  ObjectLibraryStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import Foundation

class ObjectLibraryStore: ObservableObject {
    
    @Published var selectedType: ObjectTypes? {
        willSet { if newValue == selectedType { return } }
        didSet { sendObjectChangedNotification() }
    }
    
    var selectedObject: LibraryObjectDef? {
        if selectedType == nil { return nil }
        var selectedCategory: ObjectCategories?
        var selectedSubCategory: ObjectSubCategories?
        for category in ObjectsMap {
            for subCategory in category.value {
                for type in subCategory.value {
                    if type == selectedType {
                        selectedCategory = category.key
                        selectedSubCategory = subCategory.key
                        break
                    }
                }
            }
        }
        guard let metadata = ObjectsMetadata[selectedType!] else { return nil }
        return LibraryObjectDef(
            category: selectedCategory!,
            subCategory: selectedSubCategory!,
            type: selectedType!,
            metadata: metadata
        )
    }
    
    func getSubCategories(of category: ObjectCategories) -> [ObjectSubCategories] {
        return ObjectsMap[category, default: [:]].map{ $0.key }.sorted()
    }
    
    func getTypes(of category: ObjectCategories, and subCategory: ObjectSubCategories) -> [ObjectTypes] {
        return ObjectsMap[category, default: [:]][subCategory, default: []].sorted()
    }
    
    func getObjectTypes(containing value: String) -> [ObjectTypes] {
        var matchingTypes: [ObjectTypes] = []
        for category in ObjectsMap {
            for subCategory in category.value {
                for type in subCategory.value {
                    if type.rawValue.lowercased().contains(value.lowercased()) { matchingTypes.append(type) }
                }
            }
        }
        return matchingTypes
    }
    
    private func sendObjectChangedNotification() {
        if selectedType == nil { return }
        NotificationController.instance.post(name: .onObjectSelected, object: selectedObject)
    }
}
