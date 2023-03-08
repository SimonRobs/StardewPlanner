//
//  LibraryNavigationViewContent.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryNavigationViewContent: View {
    
    var subCategories: [ObjectSubCategories]
    @Binding var selectedSubCategory: ObjectSubCategories?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(subCategories, id: \.self) { subCategory in
                Button(action: { selectedSubCategory = subCategory }) {
                    Text(subCategory.rawValue)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DarkButtonStyle(isSelected: subCategory == selectedSubCategory, noCornerRadius: true ))
            }
            Spacer()
        }
        .background(Color.background)
    }
}

struct LibraryNavigationViewContent_Previews: PreviewProvider {
    static var previews: some View {
        LibraryNavigationViewContent(subCategories: [.Spring, .Summer, .Fall], selectedSubCategory: .constant(.Summer))
    }
}
