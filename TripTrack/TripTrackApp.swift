//
//  TripTrackApp.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct TripTrackApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            Group {
                
                if Auth.auth().currentUser != nil {
                    MainView()
                } else {
                    ContentView()
                }
            } .preferredColorScheme(.dark)
        }
    }
}
