//
//  SettingsView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import SwiftUI

struct SettingsView: View {
    //    MARK: - PROPERTIES
    let title = "Settings"
    let backImage = "back"
    
    //    MARK: - BODY
    var body: some View {
        
        ZStack {
            fullBackground(imageName: backImage)

        }
    }
}

//  MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
