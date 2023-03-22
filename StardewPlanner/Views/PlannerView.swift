//
//  PlannerView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI
import SpriteKit

// TODO: Move this to a SceneStore
let farmScene = SKScene(fileNamed: "FarmScene")!

struct PlannerView: View {
    
    @State private var isLibraryPresented = false
    
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

