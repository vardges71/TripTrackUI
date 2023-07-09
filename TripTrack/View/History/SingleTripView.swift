//
//  SingleTripView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import SwiftUI

struct SingleTripView: View {
//    MARK: - PROPERTIES
    
    let trip: Trip
    
    let title = "Single Trip"
    let backImage = "back"
    
//    MARK: - BODY
    var body: some View {
        ZStack {
            fullBackground(imageName: backImage)
            VStack {
                Text(trip.vehicleMake)
            }
        }
    }
}
//  MARK: - PREVIEW
struct SingleTripView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTripView(trip: Trip())
    }
}
