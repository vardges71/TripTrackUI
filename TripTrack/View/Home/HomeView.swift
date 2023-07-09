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
    
    @StateObject var homeMV = HomeViewModel()
    @StateObject var user: User = User()
    let title = "TripTrack"
    
    @State private var showMessage = false
    
    //    MARK: - BODY
    var body: some View {
        
        NavigationView {
            ZStack {
                fullBackground(imageName: backImage)
                VStack {
                    Text(homeMV.greetingText)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text(homeMV.lastTripText)
                        .onLongPressGesture(perform: {
                            UIPasteboard.general.string = homeMV.lastTripText
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showMessage = true
                                }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    showMessage = false
                                }
                            }
                        })
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                    Spacer()
                    if showMessage {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("messageBack"))
                            .scaleEffect(showMessage ? 1.0 : 0.0)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .padding()
                            .overlay {
                                Text("copied")
                                    .foregroundColor(.gray)
                            }
                    }
                }
                .foregroundColor(.accentColor)
                .onAppear{
                    homeMV.getUserCredential()
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
