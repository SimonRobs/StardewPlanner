//
//  ObjectCategoryDisclosureGroupItem.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-09.
//

import SwiftUI

struct ObjectCategoryDisclosureGroupItem: View {
    
    @EnvironmentObject() var libraryStore: ObjectLibraryStore
    @EnvironmentObject var configsStore: GlobalConfigurationStore
    
    let type: ObjectTypes
    
    var isSelected: Bool {
        return type == libraryStore.selectedType
    }
    
    var body: some View {
        Button(action: selectObject) {
            HStack {
                Image(getImageName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(idealHeight: 32)
                Text(type.rawValue)
                    .foregroundColor(.white)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .buttonStyle(ListButtonStyle(isSelected: isSelected))
    }
    
    private func selectObject() {
        libraryStore.selectedType = type
    }
    
    private func getImageName() -> String {
        if ObjectsMetadata[type]!.seasonal == true {
            return "\(configsStore.selectedSeason.rawValue) \(type.rawValue)"
        }
        return type.rawValue
    }
}

struct ObjectCategoryDisclosureGroupItem_Previews: PreviewProvider {
    static var previews: some View {
        ObjectCategoryDisclosureGroupItem(type: .Parsnip)
    }
}
