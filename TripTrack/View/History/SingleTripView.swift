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
    
    @State private var showMessage = false
    
//    MARK: - BODY
    var body: some View {
        ZStack {
            fullBackground(imageName: backImage)
            VStack {
                Spacer()
                Text(trip.vehicleVIN)
                    .onLongPressGesture(perform: {
                        UIPasteboard.general.string = trip.vehicleVIN
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showMessage = true
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                showMessage = false
                            }
                        }
                    })
                Spacer()
                if showMessage {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("messageBack"))
                        .scaleEffect(showMessage ? 1.0 : 0.0)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .padding()
                        .overlay {
                            Text("copied")
                                .foregroundColor(.gray)
                        }
                }
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
