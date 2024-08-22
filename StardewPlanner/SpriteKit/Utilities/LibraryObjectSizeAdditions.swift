//
//  LibraryObjectSizeAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-30.
//

import Foundation

extension LibraryObjectSize {
    func toSceneSize(noVerticalOverflow: Bool = false) -> CGSize {
        return CGSize(
            width: CGFloat(columns) * TileSize,
            height: CGFloat(rows) * TileSize + ((noVerticalOverflow) ? 0 : CGFloat(verticalOverflow) * TileSize)
        )
    }
}
