//
//  LibraryNavigationViewDetail.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-07.
//

import SwiftUI

struct LibraryNavigationViewDetail: View {
    
    var types: [ObjectTypes]
    @Binding var selectedType: ObjectTypes?
    
    private let columnDefinition = [GridItem(.adaptive(minimum: 152, maximum: 152))]
    private let maxImageHeight: CGFloat = 82
    
    var body: some View {
        if types.count < 1 {
            VStack {
                Spacer()
                Text("No Results")
                Spacer()
            }
        } else {
            ScrollView {
                LazyVGrid(columns: columnDefinition) {
                    ForEach(types, id: \.self) { type in
                        Button(action: { selectedType = type }) {
                            VStack {
                                Image(type.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: maxImageHeight)
                                    .padding()
                                Text(type.rawValue)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                        .buttonStyle(DarkButtonStyle(isSelected: type == selectedType))
                    }
                }
                .padding()
            }
        }
    }
}

struct LibraryNavigationViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        LibraryNavigationViewDetail(types: [.BlueJazz, .Parsnip], selectedType: .constant(.Parsnip))
    }
}
