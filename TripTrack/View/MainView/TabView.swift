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
                isSettingsVisible = false
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
                isSettingsVisible = false
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
                isSettingsVisible = false
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
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSettingsVisible.toggle()
                    }
                }
            Spacer()
        }
    }
}

//  MARK: - PREVIEW

struct TabView_Previews: PreviewProvider {

    static var previews: some View {
        TabView(tabSelected: .constant(.home), isSettingsVisible: .constant(false))
    }
}
