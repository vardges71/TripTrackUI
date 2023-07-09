//
//  ContentView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
//    MARK: - PROPERTIES
    
    @StateObject var scanResultVM = ScanResultViewModel()
    
//    MARK: - BODY
    var body: some View {
        
        VStack {
            if Auth.auth().currentUser != nil {
                
                if scanResultVM.isStartLocationSetted == false {
                    MainView()
                } else {
                    ScanResultView()
                }
                
            } else {
                LoginView()
            }
        } .onAppear {
            scanResultVM.validateDestinationPoint()
        }
    }
}

//  MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
