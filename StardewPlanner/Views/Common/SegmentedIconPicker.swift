//
//  SegmentedIconPicker.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2023-02-07.
//

import SwiftUI

struct SegmentedIconPicker<SelectionValue : Identifiable & Hashable>: View {
    let options: [SelectionValue]
    let optionToIconName: (SelectionValue) -> String
    let singleSelection: Bool

    @Binding
    var selection: Set<SelectionValue>
    
    init(options: [SelectionValue], optionToIconName: @escaping (SelectionValue) -> String, selection: Binding<Set<SelectionValue>>, singleSelection: Bool = false) {
        self.options = options
        self.optionToIconName = optionToIconName
        self.singleSelection = singleSelection
        self._selection = selection
    }
    
    var body: some View {
        HStack {
            ForEach(options) { option in
                Button(action: { toggleSelection(selected: option) }) {
                    Image(systemName: optionToIconName(option))
                        .font(.title3)
                        .frame(maxWidth: 32, minHeight: 32)
                }
                .buttonStyle(DarkButtonStyle(isSelected: selection.contains(option)))
                
                if option != options.last {
                    Divider()
                        .frame(height: 8)
                }
            }
        }
        .padding(8)
        .background(Color.background)
        .cornerRadius(8)
    }

    private func toggleSelection(selected: SelectionValue) {
        if singleSelection { selection.removeAll(); selection.insert(selected) }
        else if let existingIndex = selection.firstIndex(where: { $0.id == selected.id }) {
            selection.remove(at: existingIndex)
        } else {
            selection.insert(selected)
        }
    }
}

struct SegmentedIconPicker_Previews: PreviewProvider {
    
    struct DummyIdentifiable: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }
    
    @State
    static var selection: Set<DummyIdentifiable> = [.init(string: "1"),.init(string: "4")]
    
    static var previews: some View {
        SegmentedIconPicker(
            options: [1,2,3,4,5].map({ DummyIdentifiable(string: "\($0)") }),
            optionToIconName: { $0.string },
            selection: $selection
        )
    }
}
