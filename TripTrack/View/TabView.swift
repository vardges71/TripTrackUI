//
//  TabView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-14.
//

import SwiftUI

struct TabView: View {
    
//    MARK: - PROPERTIES
    
    @Binding var tabSelected: Tab
    @Binding var isSettingsVisible: Bool
    
//    MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                tabSelected = .home
            } label: {
                VStack {
                    Image(systemName: tabSelected == .home ? "house.fill" : "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("home")
                        .font(.caption2)
                }
                .foregroundColor(tabSelected == .home ? .accentColor : Color.gray)
            }
            Spacer()
            Button {
                tabSelected = .scan
            } label: {
                VStack {
                    Image(systemName: tabSelected == .scan ? "camera.fill" : "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("scan")
                        .font(.caption2)
                }
                .foregroundColor(tabSelected == .scan ? .accentColor : Color.gray)
            }
            Spacer()
            Button {
                tabSelected = .history
            } label: {
                VStack {
                    Image(systemName: tabSelected == .history ? "doc.plaintext.fill" : "doc.plaintext")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("history")
                        .font(.caption2)
                }
                .foregroundColor(tabSelected == .history ? .accentColor : Color.gray)
            }
            Spacer()
            
            SettingsButton(isSettingsVisible: $isSettingsVisible)
                .onTapGesture {
                    withAnimation {
                        isSettingsVisible.toggle()
                    }
                }
            Spacer()
        }
    }
}

//  MARK: - PREVIEW

//struct TabView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TabView()
//    }
//}


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
