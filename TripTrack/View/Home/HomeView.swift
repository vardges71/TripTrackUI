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
        NavigationView {
            ZStack {
                fullBackground(imageName: backImage)
                VStack {
                    Text(homeMV.greetingText)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("\(homeMV.lastTripText)")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                    Spacer()
                }
                .foregroundColor(.accentColor)
                .onAppear{
                    homeMV.getUserCredential()
                    homeMV.getLastTrip()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleTextColor(Color("projectLabel"))
    }
}

//  MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}
