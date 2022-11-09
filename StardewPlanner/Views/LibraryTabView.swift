//
//  LibraryTabView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-09.
//

import SwiftUI

struct LibraryTabView: View  {
    
    let onObjectSelected: (_ object: LibraryObject?)->Void
    
    @EnvironmentObject() var library: PlannerLibrary
    
    @State private var selectedSection: LibrarySection?
    @State private var isHovered = false
    
    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                ForEach(library.sections, id: \.name) { section in
                    LibraryTabViewButton(section.name, isSelected: section == selectedSection) {
                        selectedSection = section
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            LibraryTabViewContent(with: selectedSection?.objects ?? [])
        }
        .background(Color.background)
        .onAppear {
            selectedSection = library.sections.first
        }
    }
}


struct LibraryTabView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabView() { object in }
            .environmentObject(PlannerLibrary())
    }
}
