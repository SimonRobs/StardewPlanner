//
//  PlannerView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI
import SpriteKit




let farmScene = SKScene(fileNamed: "FarmScene")!

struct PlannerView: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            TitleBar()
            ZStack {
                SpriteView(scene: farmScene)
                    .background(VisualEffectView().ignoresSafeArea())
                    .ignoresSafeArea()
            }
        }
        .background(.black)
        .ignoresSafeArea()
        .popover(isPresented: $show) {
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .hudWindow

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}


struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}

