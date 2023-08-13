//
//  FarmingModeStore.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-03-22.
//

import Foundation

class FarmingModeStore: ObservableObject {
    
    // MARK: - Shared Flooring Mode Variables
    @Published var selectedCropType: CropTypes? = nil {
        didSet {
            NotificationController.instance.post(
                name: .onCropChanged,
                object: selectedCrop
            )
        }
    }
    
    private var selectedCrop: LibraryCrop? {
        guard let selectedCropType = self.selectedCropType else { return nil }
        return LibraryCrop(type: selectedCropType, metadata: CropsMetadata[selectedCropType])
    }
}
