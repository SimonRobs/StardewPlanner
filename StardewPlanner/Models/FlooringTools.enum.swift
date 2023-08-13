//
//  FlooringTools.enum.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-22.
//

import Foundation

enum FlooringTools: Int, CaseIterable, Codable {    
    case FreeDraw, Eraser, Shape, Line, Bucket, Eyedropper
}

extension FlooringTools {
    func getImageData() -> (Bool, String) {
        switch self {
        case .FreeDraw:
            return (false, "scribble.variable")
        case .Eraser:
            return (false, "eraser")
        case .Shape:
            return (false, "pentagon")
        case .Line:
            return (false, "line.diagonal")
        case .Bucket:
            return (true, "bucket")
        case .Eyedropper:
            return (false, "eyedropper")
        }
    }
}
