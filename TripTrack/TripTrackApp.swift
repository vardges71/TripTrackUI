//
//  TripTrackApp.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

@main
struct TripTrackApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            Group {
                
                ContentView()
            } .preferredColorScheme(.dark)
        }
    }
}
