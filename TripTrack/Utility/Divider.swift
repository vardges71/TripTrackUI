//
//  Divider.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import SwiftUI

struct Divider: View {
    var body: some View {

        Rectangle().frame(height: 1)
            .foregroundColor(.accentColor)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        Divider()
    }
}
