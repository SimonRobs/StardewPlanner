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
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
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
        VStack(spacing: 0) {
            ObjectCategoryDisclosureGroupItem(type: .Torch)
            ObjectCategoryDisclosureGroupItem(type: .GoldBrazier)
            ObjectCategoryDisclosureGroupItem(type: .SlimeHutch)
        }
            .environmentObject(GlobalConfigurationStore())
            .environmentObject(ObjectLibraryStore())
    }
}
