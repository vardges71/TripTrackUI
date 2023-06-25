//
//  HomeModelView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class HomeModelView: ObservableObject {
    
    var user = User()
    var ref: DatabaseReference = Database.database().reference()
    let date = NSDate()
    let formatter = DateFormatter()
    
    @Published var greetingText: String = ""
    @Published var lastTripText: String = ""
    
    
    // MARK: - Greeting text
    
    func greetingText(user: User) -> String{
        
        let hour = Calendar.current.component(.hour, from: Date())
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let currDate = formatter.string(from: date as Date)
        
        switch hour {
            
        case 0...11:
            self.greetingText = "Good morning \(user.fullName), \ntoday is \(currDate)"
        case 12...12:
            self.greetingText = "Good afternoon \(user.fullName), \ntoday is \(currDate)"
        case 13...17:
            self.greetingText = "Good day \(user.fullName), \ntoday is \(currDate)"
        case 18...23:
            self.greetingText = "Good evening \(user.fullName), \ntoday is \(currDate)"
        default:
            self.greetingText = "Good day"
        }
        
        print(greetingText)
        return greetingText
    }
    
    // MARK: - Get user credentials
    
    func getUserCredential() -> User {
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID ?? " ").child("credentials").observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            self.user.fullName = value?["fullname"] as? String ?? ""
            user.email = value?["email"] as? String ?? ""
            
            self.greetingText(user: self.user)
            
        }) { (error) in
            //            print(error.localizedDescription)
        }
        
        return user
    }
    
    // MARK: - Get Last Trip
    
    func getLastTrip() -> String {
        
        let lastTrip = Trip()
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users").child(userID ?? " ").child("trips")

        ref.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary
            lastTrip.tripId = value?["tripID"] as? String ?? ""
            lastTrip.startDate = value?["startDate"] as? String ?? ""
            lastTrip.startLocation = value?["startLocation"] as? String ?? ""
            lastTrip.endLocation = value?["finishLocation"] as? String ?? ""
            lastTrip.vehicleVIN = value?["vinCode"] as? String ?? ""
            lastTrip.vehicleMake = value?["vehicleMake"] as? String ?? ""
            lastTrip.vehicleModel = value?["vehicleModel"] as? String ?? ""

            self.lastTripText = "last trip:\n\(lastTrip.startDate)\n\nstart location:\n\(lastTrip.startLocation)\ndestination:\n\(lastTrip.endLocation)\n\nvin:\n\(lastTrip.vehicleVIN)\nvehicle:\n\(lastTrip.vehicleMake + " | " + lastTrip.vehicleModel)"

        })  { (error) in
            print(error.localizedDescription)
        }
        return lastTripText
    }
}
