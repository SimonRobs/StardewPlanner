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
    
    @State private var selectedFamily: ObjectFamilies?
    @State private var isHovered = false
    
    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                ForEach(ObjectFamilies.allCases, id: \.self) { family in
                    LibraryTabViewButton(family.rawValue, isSelected: family == selectedFamily) {
                        selectedFamily = family
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            LibraryTabViewContent(with: library.objects.filter { $0.family == selectedFamily } ) { object in
                onObjectSelected(object)
            }
        }
        .background(Color.background)
        .onAppear {
            selectedFamily = library.objects.first?.family
        }
    }
}


struct LibraryTabView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryTabView() { object in }
            .environmentObject(PlannerLibrary())
    }
}
