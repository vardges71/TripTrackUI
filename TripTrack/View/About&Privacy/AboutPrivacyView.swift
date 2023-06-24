//
//  AboutPrivacyView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI

struct AboutPrivacyView: View {
//    MARK: - PROPERTIES
    
    var backImageName = "back"
    
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    
//    MARK: - BODY
    var body: some View {
        
        ZStack {
            fullBackground(imageName: backImageName)
            
            VStack(alignment: .leading) {
                Text("TripTrack")
                Text("Version \(appVersionString) (#\(buildNumber))")
                    .font(.footnote)
            }
            .foregroundColor(.accentColor)
        }
    }
}

//  MARK: - PREVIEW
struct AboutPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPrivacyView()
    }
}
