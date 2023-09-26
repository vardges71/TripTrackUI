//
//  Location.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-03.
//

import SwiftUI

public class Location: ObservableObject {
    
    @Published var curCity: String = ""
    @Published var curState: String = ""
    @Published var curCountry: String = ""
}
