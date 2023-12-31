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
                        CameraView()
                    }
                case .history:
                    NavigationView {
                        HistoryView(tabSelected: $tabSelected)
                    }
                }
                TabView(tabSelected: $tabSelected, isSettingsVisible: $isSettingsVisible)
                
            } .background(Color("projectNav"))
            
            SettingView(isSettingsVisible: $isSettingsVisible)
                .offset(y: -70)
        }
    }
}

//  MARK: - PREVIEW
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
