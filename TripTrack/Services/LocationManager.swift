//
//  LocationManager.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-02.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    let loc = Location()
    
    @Published var myState: String = ""
    @Published var myCity: String = ""
    @Published var myCountry: String = ""
    
    @Published var fullAddress: String = ""
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.distanceFilter = 10
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = 10
    }
    
    func startUpdatingLocation() {
        
        locationManager.startUpdatingLocation()
        
    }
    
    func stopUpdatingLocation() {
        
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method
    
//    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
//
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in completion(placemarks?.first?.locality, placemarks?.first?.country, error) }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            
            self?.myCity = (placemarks?.first?.locality)!
            self?.myState = (placemarks?.first?.administrativeArea)!
            self?.myCountry = (placemarks?.first?.country)!
            
            self?.fullAddress = "\((placemarks?.first?.subThoroughfare)!) \((placemarks?.first?.thoroughfare)!),\n\((placemarks?.first?.locality)!), \((placemarks?.first?.postalCode)!), \((placemarks?.first?.administrativeArea)!),\n\((placemarks?.first?.country)!)"
            
            self!.loc.curCity = self!.myCity
            self!.loc.curState = self!.myState
            self!.loc.curCountry = self!.myCountry
            
//            print("FROM LOCATION: \(self!.loc.curCity), \(self!.loc.curState). \(self!.loc.curCountry)")
//            print("FROM LOCATION: \(self!.fullAddress)")
                
        }
        
        locationManager.stopUpdatingLocation()
    }
}
