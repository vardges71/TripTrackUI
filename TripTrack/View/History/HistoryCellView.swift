//
//  HistoryCellView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import SwiftUI

struct HistoryCellView: View {
    
//    MARK: - PROPERTIES
    
    let trip: Trip
    
    @State private var isMonday = false
    
//    MARK: - BODY
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                tripInfoSection(label: "start date:", result: tripStartDate())
                tripInfoSection(label: "start location:", result: trip.startLocation)
            }
            .background(Color.clear)
        }
    }
    
    func tripStartDate() -> String {
        
        var tripStartDate = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM. yyyy, HH:mm"
        let dateFromStringstartDate: Date = dateFormatter.date(from: trip.startDate)! as Date
        
        let weekDayDateFormatter = DateFormatter()
        weekDayDateFormatter.dateFormat = "EEEE"
        let weekDay = weekDayDateFormatter.string(from: dateFromStringstartDate)
        
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: dateFromStringstartDate)
        tripStartDate = "\(weekDay), \(trip.startDate), week: \(weekOfYear)"

        return tripStartDate
    }
}

//  MARK: - PREVIEW
struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView(trip: Trip())
    }
}
