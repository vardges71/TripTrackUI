//
//  LogoView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct LogoView: View {
//    MARK: - PROPERTIES
    
    let logoSize = UIScreen.main.bounds.width * 0.7
    
//    MARK: - BODY
    var body: some View {
        Image("logotriptracktrans_new")
            .resizable()
            .scaledToFit()
            .frame(width: logoSize)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
