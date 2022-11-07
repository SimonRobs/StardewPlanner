//
//  LibraryView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-07.
//

import SwiftUI

struct LibraryView: View  {
    
    @EnvironmentObject() var objectLibrary: PlannerLibrary
    
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
            .padding(.leading, 76)
            .background(Color.lightBackground)
            .ignoresSafeArea()
            
            NavigationSplitView(sidebar:{
                List(objectLibrary.objects, selection: $selectedObjectId) { object in
                    Text(object.name)
                        .draggable(object.iconName)
                }
            }, detail: {
                if let selectedObjectId = selectedObjectId {
                    Text("\(selectedObjectId)")
                } else {
                    Image(systemName: "clear")
                }
                Spacer()
            })
            .navigationSplitViewStyle(.prominentDetail)
        }
        .background(Color.background)
        .ignoresSafeArea()
    }
}
