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
    let title = "About&Privacy"
    
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    
//    MARK: - BODY
    var body: some View {
        
        NavigationStack {
            ZStack {
                fullBackground(imageName: backImageName)
                
                VStack(alignment: .leading) {
                    Divider()
                    Text("TripTrack")
                        .font(.title2)
                    Text("Version \(appVersionString) (#\(buildNumber))")
                        .font(.footnote)
                    Text("©2023 Vardges Gasparyan. All Rights Reserved")
                    Divider()
                    PrivacyView()
                }
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
            .navigationTitle(title)
            .navigationBarTitleTextColor(Color("projectLabel"))
        }
    }
}

//  MARK: - PREVIEW
struct AboutPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPrivacyView()
    }
}
