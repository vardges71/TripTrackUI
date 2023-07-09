//
//  Utility.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase

class Utilities {
    
    //  MARK: - PROPERTIES
    
    @ObservedObject var user: User = User()
    
    //  MARK: - Password Validate
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let pwdRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", pwdRegEx)
        
        return passwordTest.evaluate(with: password)
    }
    
    //  MARK: - Log Out
    
    static func logOut() {
        
        let firebaseAuth = Auth.auth()
        
        do {
            
            try firebaseAuth.signOut()
            print ("User loged out")
            
        } catch let signOutError as NSError {
            
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //  MARK: - Delete Account
    
    static func deleteAccount() {
        
        let user = Auth.auth().currentUser
        let ref = Database.database().reference().child("users").child(user!.uid)
        
        ref.removeValue { error, _ in
            print(error as Any)
        }
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                print("ERROR!!! - \(error)")
            } else {
                // Account deleted.
                print("USER DELETED")
            }
        }
    }
    
    // MARK: - Get Current Date&Time
    
    static func getCurrentDateTime () -> String {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy, HH:mm"
        timeFormatter.timeStyle = .medium
        
        let currDateTime = (dateFormatter.string(from: date as Date) + "\n" + timeFormatter.string(from: date as Date))
        
        return currDateTime
    }
    
    static func curDateTimeForDB() -> String {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        //        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM. yyyy, HH:mm"
        //        timeFormatter.timeStyle = .short
        
        let currDateTime = (dateFormatter.string(from: date as Date))
        
        return currDateTime
    }
    
    // MARK: - Create Ttrip ID
    
    static func tripId() -> String {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        //        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        //        timeFormatter.timeStyle = .short
        
        let currDateTime = (dateFormatter.string(from: date as Date))
        
        return currDateTime
    }
    
    // MARK: - Get Last Trip ID
    
    static func getLastTripID() {
        
        var ref: DatabaseReference!
        let lastTripID = Trip()
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("users").child(userID!).child("trips")
        
        ref.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            lastTripID.tripId = value?["tripID"] as? String ?? ""
            
            UserDefaults.standard.set(lastTripID.tripId, forKey: "lastTripID")
        })  { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get Monday in trip history
    
    static func initNewWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: Date())
        
        print(weekDay)
        
        return weekDay
    }
}
