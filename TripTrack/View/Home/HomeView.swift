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
    
    @StateObject var homeMV = HomeModelView()
    @StateObject var user: User = User()
    let title = "TripTrack"
    
    //    MARK: - BODY
    var body: some View {
        ZStack {
            fullBackground(imageName: backImage)
            VStack {
                Text(homeMV.greetingText)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Spacer()
                Text("\(homeMV.lastTripText)")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                Spacer()
            }
            .padding(20)
            .onAppear{
                homeMV.getUserCredential()
                homeMV.getLastTrip()
            }
        } .foregroundColor(.accentColor)
    }
}

//  MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}
