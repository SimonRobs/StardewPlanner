//
//  LibraryView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct LibraryView: View  {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTab = 0
    @State private var searchString = ""
    @State private var selectedObjectId: LibraryObject.ID?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.white)
                    .font(.title2)
                TextField("Search", text: $searchString)
                    .preferredColorScheme(.dark)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
            }
            .padding([.leading, .trailing])
            .background(Color.lightBackground)
            .ignoresSafeArea()
            LibraryTabView() { object in
                NotificationController.instance.post(name: .onObjectSelected, object: object)
                dismiss()
            }
        }
        .background(Color.background)
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environmentObject(PlannerLibrary())
    }
}

