//
//  CameraViewBottomPanel.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-25.
//

import SwiftUI
import AVFoundation

struct CameraViewBottomPanel: View {
    
//    MARK: - PROPERTIES
    
    @StateObject var veh = Vehicle()
    
    @State private var isTorchOn = false
    @State private var isManualInputActive = false
    @State private var enteredVin = ""
    @Binding var showScanResult: Bool
    
//    MARK: - BODY
    var body: some View {
        
        HStack {
            
            Button {
                isManualInputActive.toggle()
//                UserDefaults.standard.removeObject(forKey: "vinCode")
            } label: {
                VStack {
                    Image(systemName: "square.and.pencil")
                        .environment(\.symbolVariants, .none)
                    Text("manual input")
                        .font(.caption)
                } .foregroundColor(isManualInputActive ? .white : .accentColor)
            }
            .alert("VIN CODE", isPresented: $isManualInputActive) {
                TextField("vin code:", text: $enteredVin)
                    .textInputAutocapitalization(.never)
//                    .foregroundColor(Color("projectNav"))
                Button("Submit", role: .destructive) {
                    
                    veh.vin = enteredVin
                    UserDefaults.standard.set(veh.vin, forKey: "vinCode")
                    showScanResult = true
                    
                    print("VIN IS: \(veh.vin)")
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enter vin code in the field.")
            }
            Spacer()
            Button {
                
                isTorchOn.toggle()
                flashlightButtonTapped()
                
            } label: {
                VStack {
                    Image(systemName: isTorchOn ? "bolt.fill" : "bolt")
                        .environment(\.symbolVariants, .none)
                    Text("light")
                        .font(.caption)
                }
                .foregroundColor(isTorchOn ? Color("projectYellow") : .accentColor)
            }
        }
        .padding(.horizontal, 40)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.06)
        .background(Color("projectNav"))
    }
    
    
    
    func flashlightButtonTapped () {
        
        isTorchOn ? toggleTorch(on: true) : toggleTorch(on: false)
    }
    
    func toggleTorch(on: Bool) {
        
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = on ? .on : .off
            
            if on {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
            
        } catch {
            print("Error: \(error)")
        }
    }
}

//  MARK: - PREVIEW

struct CameraViewBottomPanel_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewBottomPanel(showScanResult: .constant(false))
    }
}
