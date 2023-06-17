//
//  HistoryView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import SwiftUI

struct HistoryView: View {
    //    MARK: - PROPERTIES
    let title = "History"
    let backImage = "back"
    
    //    MARK: - BODY
    var body: some View {
        
        NavigationView {
            ZStack {
                fullBackground(imageName: backImage)
                VStack {
                    Text("History view")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleTextColor(Color(.lightGray))
    }
}

//  MARK: - PREVIEW

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
