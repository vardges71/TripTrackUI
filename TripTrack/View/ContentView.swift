//
//  ContentView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct ContentView: View {
    
//    MARK: - PROPERTIES
    
    var backImageName = "back"
    
//    MARK: - BODY
    var body: some View {
        
        ZStack {
            fullBackground(imageName: backImageName)
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                    .foregroundColor(Color("projectYellow"))
            }
            .padding()
        }
    }
}

//  MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
