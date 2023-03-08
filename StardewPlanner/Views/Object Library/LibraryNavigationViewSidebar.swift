//
//  LibraryNavigationViewSidebar.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryNavigationViewSidebar: View {
    
    @Binding var selectedCategory: ObjectCategories?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(ObjectCategories.allCases, id: \.self) { category in
                Button(action: { selectedCategory = category }) {
                    Text(category.rawValue)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DarkButtonStyle(isSelected: category == selectedCategory, noCornerRadius: true ))
            }
            Spacer()
        }
        .background(Color.background)
    }
}

struct LibraryNavigationViewSidebar_Previews: PreviewProvider {
    static var previews: some View {
        LibraryNavigationViewSidebar(selectedCategory: .constant(.Buildings))
    }
}
