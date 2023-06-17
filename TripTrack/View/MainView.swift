//
//  MainTabView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

enum Tab {
    
    case home
    case scan
    case history
}

struct MainView: View {
    //    MARK: - PROPERTIES
    
    @State private var tabSelected: Tab = .home
    @State private var isSettingsVisible: Bool = false
    
    //    MARK: - BODY
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                switch tabSelected {
                case .home:
                    NavigationView {
                        HomeView()
                    }
                case .scan:
                    NavigationView {
                        ScanView()
                    }
                case .history:
                    NavigationView {
                        HistoryView()
                    }
                }
                TabView(tabSelected: $tabSelected, isSettingsVisible: $isSettingsVisible)
                
            } .background(Color("projectNav"))
            
            SettingButtonView(isSettingsVisible: $isSettingsVisible)
                .offset(y: -70)
        }
    }
}

struct SettingButtonView: View {
    
    @Binding var isSettingsVisible: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .background(Color.white)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .frame(width: 20, height: 20)
                }
            }
        } .opacity(isSettingsVisible ? 1 : 0)
            .transition(.scale)
        
    }
}

//  MARK: - PREVIEW
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
