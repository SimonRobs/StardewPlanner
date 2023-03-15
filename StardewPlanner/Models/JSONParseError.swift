//
//  JSONParseError.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

import Foundation

enum JSONParseError: Error {
    case fileNotFound
    case dataInitialisation(error: Error)
    case decoding(error: Error)
}
