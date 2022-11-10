//
//  LibraryTabViewContentItem.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabViewContentItem: View  {
    
    let item: LibraryObject
    private let imageFrame: CGSize
    
    @State private var isHovered = false
    
    init(for item: LibraryObject) {
        self.item = item
        switch item.family {
        case .Buildings:
            imageFrame = CGSize(width: 128, height: 128)
        default:
            imageFrame = CGSize(width: 32, height: 32)
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(isHovered ? Color.lightBackground : Color.background)
            VStack {
                Spacer()
                Image(item.type.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageFrame.width, height: imageFrame.height)
                    .padding()
                Text(item.type.rawValue)
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }
            .padding()
        }
        .draggable(item)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}


struct LibraryTabViewContentItem_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabViewContentItem(for: LibraryObject(family: .Buildings, type: .Barn))
    }
}
