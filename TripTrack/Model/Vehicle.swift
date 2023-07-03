//
//  Vehicle.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-30.
//

import Foundation

class Vehicle: ObservableObject {
    
    @Published var vin = ""
    @Published var make = ""
    @Published var model = ""
    @Published var year = ""
    @Published var manufacturer = ""
    @Published var madeIn = ""
}
