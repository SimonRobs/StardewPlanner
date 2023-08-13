//
//  LibraryObjectSizeAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-30.
//

import Foundation

extension LibraryObjectSize {
    func toSceneSize() -> CGSize {
        return CGSize(
            width: CGFloat(columns) * TileSize,
            height: CGFloat(rows) * TileSize + CGFloat(verticalOverflow) * TileSize
        )
    }
}
