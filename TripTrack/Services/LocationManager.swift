//
//  LocationManager.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-02.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var loc = Location()
    
    @Published var myState: String = "" {
        willSet { objectWillChange.send() }
    }
    @Published var myCity: String = "" {
        willSet { objectWillChange.send() }
    }
    @Published var myCountry: String = "" {
        willSet { objectWillChange.send() }
    }
    
    @Published var fullAddress: String = "" {
        willSet { objectWillChange.send() }
    }
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.allowsBackgroundLocationUpdates = false
        
    }
    
    func startUpdatingLocation() {
        
        locationManager.startUpdatingLocation()
        print("FROM START FUNCTION: \(self.myCity), \(self.myState). \(self.myCountry)")
    }
    
    func stopUpdatingLocation() {
        
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if let city = placemarks?.first?.locality {
                DispatchQueue.main.async {
                    self.myCity = city
                    self.loc.curCity = city
                }
            }
            if let state = placemarks?.first?.administrativeArea {
                DispatchQueue.main.async {
                    self.myState = state
                    self.loc.curState = state
                }
            }
            if let country = placemarks?.first?.country {
                DispatchQueue.main.async {
                    self.myCountry = country
                    self.loc.curCountry = country
                }
            }
            
//            self.fullAddress = "\((placemarks?.first?.subThoroughfare)!) \((placemarks?.first?.thoroughfare)!),\n\(self.myCity), \(self.myState),\n\((placemarks?.first?.postalCode)!), \(self.myCountry)"
            
            self.loc.curCity = self.myCity
            self.loc.curState = self.myState
            self.loc.curCountry = self.myCountry
            
            print("FROM LOCATION MANAGER: \(self.loc.curCity), \(self.loc.curState). \(self.loc.curCountry)")
//            print("FROM LOCATION: \(self.fullAddress)")
                
        }
        
//        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
