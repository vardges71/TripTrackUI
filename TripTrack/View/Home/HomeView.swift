//
//  HomeView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import SwiftUI

struct HomeView: View {
    //    MARK: - PROPERTIES

    let backImage = "back"
    
    //    MARK: - BODY
    var body: some View {
        ZStack {
            fullBackground(imageName: backImage)
            VStack {
                Text("Home view!")
                    .foregroundColor(.accentColor)
            }
        }
    }
}

//  MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
