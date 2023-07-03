//
//  ScanResultViewModel.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-30.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseDatabase

protocol UploadVehicleDelegate: AnyObject {
    
    func getVehicleInfo(vehicle: Vehicle)
}
class ScanResultViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var makeRes = ""
    @Published var modelRes = ""
    @Published var yearRes = ""
    @Published var vinRes = UserDefaults.standard.string(forKey: "vinCode") ?? ""
    @Published var madeInRes = ""
    @Published var manufacturerRes = ""
    
    func load() {

        WebService().parseJSON(scanResVM: self)
    }
    
    func validateDestinationPoint() {
        
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        ref.child("users").child(userID!).child("trips").queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            if (snapshot.hasChild("finishLocation")) {
                
                
            } else {

//                self.setStartPointButton.isHidden = true
//                self.setFinishPointButton.isHidden = false
//                self.startLocationLabel.text = "finish location:"
            }
        })
    }
}

extension ScanResultViewModel: UploadVehicleDelegate {
    
    func getVehicleInfo(vehicle: Vehicle) {
        self.makeRes = vehicle.make
        self.modelRes = vehicle.model
        self.yearRes = vehicle.year
        self.madeInRes = vehicle.madeIn
        self.manufacturerRes =  vehicle.manufacturer
    }
}
