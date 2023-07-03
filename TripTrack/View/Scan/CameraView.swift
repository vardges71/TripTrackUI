//
//  CameraView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import SwiftUI

struct CameraView: View {
    
//    MARK: - PROPERTIES
    
    @State var showScanResult = false
    
//    MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                CameraViewBottomPanel(showScanResult: $showScanResult)
                ScanView()
                    .offset(y: 10)
                
            } .fullScreenCover(isPresented: $showScanResult) { ScanResultView() }
        }
    }
}

//  MARK: - PREVIEW
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
