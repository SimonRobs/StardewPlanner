//
//  EnvironmentAdditions.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

private struct IsLibraryPresentedKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isLibraryPresented: Binding<Bool> {
        get { self[IsLibraryPresentedKey.self] }
        set { self[IsLibraryPresentedKey.self] = newValue }
    }
}
