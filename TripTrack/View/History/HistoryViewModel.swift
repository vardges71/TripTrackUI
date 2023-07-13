//
//  HistoryViewModel.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol UploadHistoryDelegate: AnyObject {
    
    func getHistory(_ trips: [Trip])
}

class HistoryViewModel: ObservableObject {
    
    @Published var tripsArray: [Trip] = []
    @Published var isHistoryEmpty = false
    @Published var shouldAnimate = false
    
    func loadHistory() {
        
        GetHistory().getTripsHistory(tripsHistoryVM: self)
    }
    
    func checkIsHistoryEmpty() {
        
        if isHistoryEmpty { loadHistory() }
    }
    
    
}

extension HistoryViewModel: UploadHistoryDelegate {
    
    func getHistory(_ trips: [Trip]) {
        
        self.tripsArray = trips
        
        if tripsArray.isEmpty {
            
            isHistoryEmpty = true
            shouldAnimate.toggle()
        }
//        print("HVM trip array count \(self.tripsArray.count)")
    }
}
