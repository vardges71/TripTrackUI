//
//  Trip.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import Foundation

class Trip: ObservableObject, Identifiable {
    
    @Published var tripId: String = ""
    @Published var vehicleVIN: String = ""
    @Published var vehicleMake: String = ""
    @Published var vehicleModel: String = ""
    @Published var startLocation: String = ""
    @Published var endLocation: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    @Published var payed: Bool = false
    @Published var payAmount: Double = 0.0
}
