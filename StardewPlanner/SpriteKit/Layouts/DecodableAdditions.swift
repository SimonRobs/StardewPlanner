//
//  DecodableAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-01-25.
//

import Foundation

extension Decodable {
    static func from(localJSON filename: String) -> Result<Self, JSONParseError> {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return .failure(.fileNotFound)
        }
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch let error {
            return .failure(.dataInitialisation(error: error))
        }

        do {
            return .success(try JSONDecoder().decode(self, from: data))
        } catch let error {
            return .failure(.decoding(error: error))
        }
    }
}
