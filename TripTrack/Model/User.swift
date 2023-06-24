//
//  User.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

class User: ObservableObject {
    
    @Published var fullName: String = ""
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}
