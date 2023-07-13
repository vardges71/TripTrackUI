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
    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    
    @StateObject var scanResultVM = ScanResultViewModel()
    @StateObject var locMan = LocationManager()
    
    @State private var isResScan = false
    @State private var showMainView = false
    
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
                        Spacer()
                        scanResultVM.isStartLocationSetted ? vehicleInfoSection(label: "finish location:", result: "\(locMan.myCity), \(locMan.myState). \(locMan.myCountry)") : vehicleInfoSection(label: "start location:", result: "\(locMan.myCity), \(locMan.myState). \(locMan.myCountry)")
                        
                        Text(Utilities.getCurrentDateTime())
                            .foregroundColor(.accentColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    VStack {
                        Spacer()
                        if scanResultVM.isStartLocationSetted == false {
                            
                            Button(action: {
                                
                                scanResultVM.isStartLocationSetted.toggle()
                                scanResultVM.startPointButtonTapped()
                                
                                impactHeavy.impactOccurred()
                                
                            }) {
                                Text("Start")
                                    .frame(width: 70, height: 70)
                                    .background(Color.accentColor)
                                    .foregroundColor(Color("projectNav"))
                                    .clipShape(Circle())
                                
                            } .overlay(
                                RoundedRectangle(cornerRadius: 35.0).stroke(lineWidth: 2)
                            )
                            
                        } else {
                            
                            Button(action: {
                                
                                scanResultVM.isStartLocationSetted.toggle()
                                scanResultVM.finishPointButtonTapped()
                                
                                impactHeavy.impactOccurred()
                                
                            }) {
                                Text("Finish")
                                    .frame(width: 70, height: 70)
                                    .background(Color("projectRed"))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                
                            } .overlay(
                                RoundedRectangle(cornerRadius: 35.0).stroke(lineWidth: 2)
                            )
                        }
                        Spacer()
                        if scanResultVM.isStartLocationSetted == true {
                            
                        } else {
                            Button("rescan") {
                                isResScan.toggle()
                                UserDefaults.standard.removeObject(forKey: "vinCode")
                            } .fullScreenCover(isPresented: $isResScan) { MainView() }
                        }
                    }
                    .fullScreenCover(isPresented: $scanResultVM.showMainView, content: {
                        MainView()
                    })
                }
                .onAppear {
                    scanResultVM.load()
                    locMan.startUpdatingLocation()
                }
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
