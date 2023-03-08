//
//  PlannerView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI
import SpriteKit

struct PlannerView: View {
    
    @State private var isLibraryPresented = false
    private let farmScene = SKScene(fileNamed: "FarmScene")!
    
    var body: some View {
        HStack(spacing: 0) {
            Toolbar()
            OptionsPanel()
            VStack(spacing: 0) {
                OptionsToolbar() 
                SpriteView(scene: farmScene)
            }
        }
        .environment(\.isLibraryPresented, $isLibraryPresented)
        .sheet(isPresented: $isLibraryPresented) {
            LibraryView()
                .frame(idealWidth: 1000, idealHeight: 600)
        }
    }
}


struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}

