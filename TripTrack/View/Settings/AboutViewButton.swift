//
//  AboutViewButton.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-16.
//

import SwiftUI

struct AboutViewButton: View {
    //    MARK: - PROPERTIES
    
    @State private var showPrivacyPolicy = false
    
    //    MARK: - BODY
    var body: some View {
        
        VStack {
            ZStack {
                Button {
                    
                    showPrivacyPolicy = true
                    
                } label: {
                    
                    VStack {
                        Image(systemName: "questionmark.square")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        Text("about&privacy")
                            .font(.caption2)
                    } .foregroundColor(Color("projectNav"))
                }
                .sheet(isPresented: $showPrivacyPolicy) {
                    AboutPrivacyView()
                        .overlay(
                            Button(action: {
                                showPrivacyPolicy = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 16)
                            .padding(.trailing, 16)
                            , alignment: .topTrailing
                        )
                }
            }
        }
    }
}

struct AboutViewButton_Previews: PreviewProvider {
    static var previews: some View {
        AboutViewButton()
    }
}
