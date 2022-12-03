//
//  OptionsPanel.swift
//  StardewPlanner
//
//  Created by Simon Robatto on 2022-12-02.
//

import SwiftUI

struct OptionsPanel: View {
    
    var body: some View {
        VStack {
            Text("Flooring")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
            
            OptionsPanelToolSelect()
            
            Divider()
            
            FlooringTilePicker()
            
            Divider()
            // Tool Options
            FreeDrawToolOptionsView()
            Spacer()
        }
        .frame(width: 256)
            .background(Color.lightBackground)
    }
}

struct OptionsPanel_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPanel()
            .frame(width: 300, height: 1024)
    }
}
