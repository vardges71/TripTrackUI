//
//  GetHistory.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import Foundation
import Firebase
import FirebaseDatabase

class GetHistory {
    
    var ref: DatabaseReference!
    
    var tripId: String = ""
    var vehicleVIN: String = ""
    var vehicleMake: String = ""
    var vehicleModel: String = ""
    var startLocation: String = ""
    var endLocation: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var payed: Bool = false
    var payAmount: Double = 0.0
    
    var trips: [Trip] = []
    var choosedTrip: Trip?
    
    func getTripsHistory(tripsHistoryVM: HistoryViewModel) {
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        ref.child("users").child(userID!).child("trips").observe(.childAdded) { (snapshot) in
            
            guard let snapChildren = snapshot.value as? [String: Any] else { return }
            
            let oneTrip = Trip()
            
            for(key, value) in snapChildren {
                
                if key == "tripID" {
                    oneTrip.tripId = value as? String ?? ""
                }
                if key == "startDate" {
                    oneTrip.startDate = value as? String ?? ""
                }
                if key == "startLocation" {
                    oneTrip.startLocation = value as? String ?? ""
                }
                if key == "finishDate" {
                    oneTrip.endDate = value as? String ?? ""
                }
                if key == "finishLocation" {
                    oneTrip.endLocation = value as? String ?? ""
                }
                if key == "payed" {
                    oneTrip.payed = value as? Bool ?? false
                }
                if key == "amount" {
                    oneTrip.payAmount = value as? Double ?? 0.0
                }
                if key == "vinCode" {
                    oneTrip.vehicleVIN = value as? String ?? ""
                }
                if key == "vehicleMake" {
                    oneTrip.vehicleMake = value as? String ?? ""
                }
                if key == "vehicleModel" {
                    oneTrip.vehicleModel = value as? String ?? ""
                }
            }
            
            self.trips.append(oneTrip)
            self.trips.sort(by: {$0.tripId > $1.tripId})
            
//            print("Total trips: \(self.trips.count)\nTrips IDs: \(oneTrip.tripId)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            
            let delegateHistory: UploadHistoryDelegate? = tripsHistoryVM
            delegateHistory?.getHistory(self.trips)
        })
    }
}
