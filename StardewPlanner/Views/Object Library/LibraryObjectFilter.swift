//
//  LibraryObjectFilter.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryObjectFilter: View {
    
    @Binding var filter: String
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .foregroundColor(.white)
                .font(.title2)
            TextField("Search", text: $filter)
                .preferredColorScheme(.dark)
                .textFieldStyle(.plain)
                .foregroundColor(.white)
                .font(.title3)
                .padding()
        }
        .padding([.leading, .trailing])
        .background(Color.lightBackground)
        .ignoresSafeArea()
    }
}

struct LibraryAutocompleteView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryObjectFilter(filter: .constant("Ba"))
    }
}
