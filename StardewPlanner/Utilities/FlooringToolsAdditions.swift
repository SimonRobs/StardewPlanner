//
//  FlooringToolsAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import Foundation

extension FlooringTools {
    func getIconName() -> String {
        switch self {
        case .FreeDraw:
            return "scribble.variable"
        case .Eraser:
            return "eraser"
        case .Shape:
            return "pentagon"
        case .Line:
            return "line.diagonal"
        case .Bucket:
            return "bucket"
        case .Eyedropper:
            return "eyedropper"
        }
    }
}
