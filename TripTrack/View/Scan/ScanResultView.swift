//
//  ScanResultView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import SwiftUI

struct ScanResultView: View {
    //    MARK: - PROPERTIES
    
    let backImage = "back"
    let title = "ScanResult"
    
    @StateObject var scanResultVM = ScanResultViewModel()
    
    @State private var isResScan = false
    
    //    MARK: - BODY
    var body: some View {
        
        NavigationStack {
            ZStack {
                fullBackground(imageName: backImage)
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        vehicleInfoSection(label: "make:", result: scanResultVM.makeRes)
                        vehicleInfoSection(label: "model:", result: scanResultVM.modelRes)
                        vehicleInfoSection(label: "year:", result: scanResultVM.yearRes)
                        vehicleInfoSection(label: "vin:", result: scanResultVM.vinRes)
                        vehicleInfoSection(label: "made in:", result: scanResultVM.madeInRes)
                        vehicleInfoSection(label: "manufacturer:", result: scanResultVM.manufacturerRes)
                    }
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    Spacer()
                    VStack {
                        Button("rescan") {
                            isResScan.toggle()
                            UserDefaults.standard.removeObject(forKey: "vinCode")
                        } .sheet(isPresented: $isResScan) { CameraView() }
                    }
                } .onAppear { scanResultVM.load() }
            }
            .navigationTitle(title)
            .navigationBarTitleTextColor(Color("projectLabel"))
        }
    }
}

//  MARK: - PREVIEW
struct ScanResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultView()
    }
}
