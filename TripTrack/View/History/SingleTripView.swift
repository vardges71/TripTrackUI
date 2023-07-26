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
    let durWidth = UIScreen.main.bounds.width * 0.5
    
    @State private var showMessage: Bool = false
    @State private var roundTrip: Bool = false
    
    //    MARK: - BODY
    var body: some View {
        
        ZStack {
            fullBackground(imageName: backImage)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        
                        Section {
                            Text("TRIP INFO:")
                                .font(.title2)
                            
                            tripInfoSection(label: "start date:", result: trip.startDate)
                            tripInfoSection(label: "start location:", result: trip.startLocation)
                            tripInfoSection(label: "finish date:", result: trip.endDate)
                            tripInfoSection(label: "finish location:", result: trip.endLocation)
                        }
                        
                        Spacer()
                        Section {
                            Text("VEHICLE INFO:")
                                .font(.title2)
                            vehicleInfoSection(label: "vin code", result: trip.vehicleVIN)
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
                            vehicleInfoSection(label: "make:", result: trip.vehicleMake)
                            vehicleInfoSection(label: "model:", result: trip.vehicleModel)
                            
                        }
                        Spacer()
                        HStack {
                            Text(countTripDuration())
                                .frame(width: durWidth, alignment: .leading)
                                .font(.callout)
                            
                            Toggle(isOn: $roundTrip) {
                                Text("round trip:")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(.callout)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        }
                    }
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                }
                .padding(.top, 60)
                .padding(.bottom, 60)
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
    func countTripDuration() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM. yyyy, HH:mm"
        let startDate = dateFormatter.date(from: trip.startDate)! as Date
        let endDate = dateFormatter.date(from: trip.endDate)! as Date
        let diffComponents = Calendar.current.dateComponents([.minute], from: startDate, to: endDate)
        
//        let minutes = (diffComponents.minute! * 2) + 60
        var minutes = 0
        
        if roundTrip == true {
            minutes = (diffComponents.minute! * 2) + 60
        } else {
            minutes = diffComponents.minute!
        }
        
        let tripDurationHours = (minutes / 60)
        let tripDurationMinutes = (minutes % 60)
        
        return "DURATION: \(tripDurationHours) h. \(tripDurationMinutes) min."
    }
}
//  MARK: - PREVIEW
struct SingleTripView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTripView(trip: Trip())
    }
}
