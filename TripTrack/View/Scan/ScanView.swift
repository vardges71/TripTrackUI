//
//  ScanView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-13.
//

import UIKit
import SwiftUI
import AVFoundation

struct ScanView: UIViewControllerRepresentable {

        
    func makeUIViewController(context: Context) -> ScannerVC {

        let scanVC = ScannerVC()
        
        return scanVC
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        // Update the view controller here
    }
}
