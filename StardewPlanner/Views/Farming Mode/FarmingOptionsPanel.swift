//
//  FarmingOptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct FarmingOptionsPanel: View {
    
    @EnvironmentObject() var libraryStore: ObjectLibraryStore
    
    // TODO: React to library type changes by opening and focusing on the recently selected object
    
    private let maxImageHeight: CGFloat = 32
    
    var body: some View {
        VStack {
            Text("Farming")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
            
            TextField("Search", text: .constant(""))
                .padding()
            
            ScrollView {
                DisclosureGroup(ObjectCategories.Crops.rawValue) {
                    ForEach(libraryStore.objectsMap[.Crops]?.map{ $0.key }.sorted(by: {$0.rawValue < $1.rawValue}) ?? [], id: \.self) { subCategory in
                        DisclosureGroup(subCategory.rawValue) {
                            VStack {
                                ForEach(libraryStore.objectsMap[.Crops]?[subCategory]?.sorted(by: {$0.rawValue < $1.rawValue}) ?? [], id: \.self) { type in
                                    Button(action: { selectObject(of: type) }) {
                                        HStack {
                                            Image(type.rawValue)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxHeight: maxImageHeight)
                                            Text(type.rawValue)
                                                .foregroundColor(.white)
                                                .font(.title3)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .buttonStyle(DarkButtonStyle(isSelected: type == libraryStore.selectedType))
                                }
                            }
                            .padding()
                        }
                        .disclosureGroupStyle(DisclosureChildStyle())
                    }
                }.disclosureGroupStyle(DisclosureParentStyle(iconName: "carrot.fill"))
                
                DisclosureGroup(ObjectCategories.Trees.rawValue) {
                }.disclosureGroupStyle(DisclosureParentStyle(iconName: "tree.fill"))
                
                DisclosureGroup(ObjectCategories.FarmingUtilities.rawValue) {
                }.disclosureGroupStyle(DisclosureParentStyle(iconName: "sprinkler.and.droplets.fill"))
            }
        }
    }
    
    func selectObject(of type: ObjectTypes) {
        libraryStore.selectedType = type
    }
}

struct FarmingOptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        FarmingOptionsPanel()
    }
}
