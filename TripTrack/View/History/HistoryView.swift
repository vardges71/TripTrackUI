//
//  HistoryView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import SwiftUI

struct HistoryView: View {
    //    MARK: - PROPERTIES
    
    @StateObject var historyVM = HistoryViewModel()
    @Binding var tabSelected: Tab
    
    let title = "History"
    let backImage = "back"
    
    //    MARK: - BODY
    var body: some View {
        
        NavigationStack {
            
                ZStack {
                    fullBackground(imageName: backImage)
                    Section {
                        VStack(alignment: .leading) {
                            Divider()
                            HistoryListView(tabSelected: $tabSelected, historyVM: historyVM)
                        }
                    }
                }
                .navigationTitle(title)
                .navigationBarTitleTextColor(Color("projectLabel"))
        }
    }
}

//  MARK: - PREVIEW

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(historyVM: HistoryViewModel(), tabSelected: .constant(.history))
    }
}
