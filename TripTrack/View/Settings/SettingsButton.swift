//
//  SettingsButton.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-16.
//

import SwiftUI

struct SettingsButton: View {
    
    @Binding var isSettingsVisible: Bool
    
    var body: some View {
        
        VStack {
            Image(systemName: isSettingsVisible ? "gear.circle.fill" : "gear.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Text("settings")
                .font(.caption2)
        }
        .foregroundColor(isSettingsVisible ? .accentColor : .gray)
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(isSettingsVisible: .constant(true))
    }
}
