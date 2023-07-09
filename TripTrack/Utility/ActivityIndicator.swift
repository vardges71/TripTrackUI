//
//  ActivityIndicator.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-08.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var shouldAnimate: Bool
    let myActivityIndicator = UIActivityIndicatorView()
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        myActivityIndicator.color = .white
        
        return myActivityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
