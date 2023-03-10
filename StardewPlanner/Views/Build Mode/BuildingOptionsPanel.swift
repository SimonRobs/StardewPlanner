//
//  BuildingOptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct BuildingOptionsPanel: View {
    
    @EnvironmentObject() var libraryStore: ObjectLibraryStore
    
    // TODO: React to library type changes by opening and focusing on the recently selected object
    
    private let maxImageHeight: CGFloat = 32
    
    var body: some View {
        VStack {
            Text("Building")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
            
            TextField("Search", text: .constant(""))
                .padding()
            
            ScrollView {
                ObjectCategoryDisclosureGroup(category: .Buildings, iconName: "house.fill")
                ObjectCategoryDisclosureGroup(category: .Equipment, iconName: "gearshape.2.fill")
                ObjectCategoryDisclosureGroup(category: .Decoration, iconName: "lamp.floor.fill")
            }
        }
    }
}

struct BuildingOptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        BuildingOptionsPanel()
    }
}
