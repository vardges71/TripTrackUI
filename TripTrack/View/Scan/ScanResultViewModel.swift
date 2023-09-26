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
import UIKit
import SwiftUI

protocol UploadVehicleDelegate: AnyObject {
    
    func getVehicleInfo(vehicle: Vehicle)
}
class ScanResultViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var vehicle = Vehicle()
    @Published var makeRes = ""
    @Published var modelRes = ""
    @Published var yearRes = ""
    @Published var vinRes = UserDefaults.standard.string(forKey: "vinCode") ?? ""
    @Published var madeInRes = ""
    @Published var manufacturerRes = ""
    
    @Published var dateResult: String = ""
    @Published var isStartLocationSetted: Bool = false
    @Published var showMainView: Bool = false
    
    var identifier = UUID()
    var trip: Trip = Trip()
    var lTripID = UserDefaults.standard.string(forKey: "lastTripID")
    
    let locMan = LocationManager()
    
    func load() {
        
        WebService().parseJSON(scanResVM: self)
        
        Utilities.getLastTripID()
        validateDestinationPoint()
    }
    
    func validateDestinationPoint() {
        
        let userID = Auth.auth().currentUser?.uid
        
        if Auth.auth().currentUser != nil {
            ref = Database.database().reference()
            ref.child("users").child(userID!).child("trips").queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in
                
                if (snapshot.hasChild("finishLocation")) {
                    
                    self.isStartLocationSetted = false
                } else {
                    
                    print("DESTINATION VALIDATED")
                    self.isStartLocationSetted = true
                }
            })
        }
    }
    
    //    MARK: - Action Buttons
    
    func startPointButtonTapped() {
        
        self.locMan.startUpdatingLocation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            
            // Validate the fields
            let error = self.validateData(vehicle: self.vehicle)
            
            if error != nil {
                
                // There's something wrong with the fields, show error message
                print(error!)
            } else {
                
                // Create cleaned version of the data
                
                let idTrip: String = Utilities.tripId()
                self.trip.tripId = idTrip
                
                let trId = self.trip.tripId
                let vin = self.vinRes
                let make = self.makeRes
                let model = self.modelRes
                
                let startLocation = String(self.locMan.myCity + ", " + self.locMan.myState + ". " + self.locMan.myCountry)
                //            let startLocation = String(loc.curCity + ", " + loc.curCountry)
                let startDate = Utilities.curDateTimeForDB()
                let userID = Auth.auth().currentUser?.uid
                
                self.ref = Database.database().reference()
                
                self.ref.child("users").child(userID!).child("trips").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if (snapshot.hasChild(trId)) {
                        
                        let alert = UIAlertController(title: "Trip already exist", message: "", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { acion in
                            
                            print("FAVORITE EXIST")
                        }))
                        
                    } else {
                        
                        self.ref = Database.database().reference(withPath: "users").child(userID!).child("trips").child(trId)
                        self.ref.setValue([
                            "tripID": trId,
                            "vinCode": vin,
                            "vehicleMake": make,
                            "vehicleModel": model,
                            "startLocation": startLocation,
                            "startDate": startDate,
                            "payed": false,
                            "amount": 0.0
                        ] as [String : Any]) { (result, err) in
                            
                            if error != nil {
                                
                                //Show erroe message
                                print("Error saving user data \(String(describing: error))")
                            }
                        }
                        Utilities.getLastTripID()
                    }
                })
            }
        })
    }
    
    func finishPointButtonTapped() {
        
//        locMan.startUpdatingLocation()
        
        let finishLocation = String(self.locMan.myCity + ", " + self.locMan.myState + ". " + self.locMan.myCountry)
//        let finishLocation = String(self.locMan.fullAddress)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            
            let error = self.validateData(vehicle: self.vehicle)
            
            let trId = UserDefaults.standard.string(forKey: "lastTripID")
            
            let finishDate = Utilities.curDateTimeForDB()
            let userID = Auth.auth().currentUser?.uid
            
            self.ref = Database.database().reference()
            
            self.ref.child("users").child(userID!).child("trips").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if (snapshot.hasChild(trId!)) {
                    
                    self.ref = Database.database().reference(withPath: "users").child(userID!).child("trips").child(trId!)
                    self.ref.updateChildValues([
                        "finishLocation": finishLocation,
                        "finishDate": finishDate
                    ]) { (result, err) in
                        
                        if error != nil {
                            
                            //Show erroe message
                            print("Error saving user data \(String(describing: error))")
                        }
                    }
                    
                    UserDefaults.standard.removeObject(forKey: "vinCode")
                    
                } else {
                    
                    print("ERRRRRRRRROOOOOOORRRRRR !!!!! \(String(describing: error))")
                }
            })
            self.locMan.stopUpdatingLocation()
            self.showMainView.toggle()
        })
    }
    
    // MARK: - Validate Data
    
    func validateData(vehicle: Vehicle) -> String? {

        // Check that all fields are filled in

        if self.vinRes == "" {

            return "Error!!!"
        }
        return nil
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
