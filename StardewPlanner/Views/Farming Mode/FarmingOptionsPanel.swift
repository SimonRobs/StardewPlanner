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
            
            Divider()
            
            ScrollView {
                ObjectCategoryDisclosureGroup(category: .Crops, iconName: "carrot.fill")
                ObjectCategoryDisclosureGroup(category: .Trees, iconName: "tree.fill")
                ObjectCategoryDisclosureGroup(category: .FarmingUtilities, iconName: "sprinkler.and.droplets.fill")
            }
        }
    }
}

struct FarmingOptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        FarmingOptionsPanel()
    }
}
