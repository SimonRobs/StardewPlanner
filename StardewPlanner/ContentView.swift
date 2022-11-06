//
//  ContentView.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-11-02.
//

import SwiftUI
import SpriteKit

extension SKView {
    open override func rightMouseDown(with event: NSEvent) {
        self.scene?.rightMouseDown(with: event)
    }
    
    open override func scrollWheel(with event: NSEvent) {
        self.scene?.scrollWheel(with: event)
    }
}


enum ToolbarItems: Int, CaseIterable, Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    case move, flooring, buildings, furniture, trees, crops
    
    var icon: String {
        switch self {
        case .move:    return "icon_cursor"
        case .flooring:   return "icon_flooring"
        case .buildings:   return "icon_buildings"
        case .furniture: return "icon_furniture"
        case .trees:   return "icon_trees"
        case .crops:   return "icon_crops"
        }
    }
}

let farmScene = SKScene(fileNamed: "FarmScene")!

struct ContentView: View {

    var body: some View {
        VStack {
            HStack {
                ForEach(ToolbarItems.allCases) { item in
                    Button(action: {print(item.self)}) {
                        HStack {
                            Image(item.icon)
                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(style: StrokeStyle(lineWidth: 0))
                        )
                    }
                    .buttonStyle(.borderless)
                }
                Spacer()
            }
            .padding(.top, 28)
            .padding(.leading, 8)
            SpriteView(scene: farmScene)
        }
        .background(VisualEffectView().ignoresSafeArea())
        .ignoresSafeArea()
    }
}


struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .underWindowBackground

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

