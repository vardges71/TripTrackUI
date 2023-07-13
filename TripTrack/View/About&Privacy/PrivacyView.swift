//
//  PrivacyView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-07-12.
//

import SwiftUI

struct PrivacyView: View {
    
//    MARK: - PROPERTIES
    
    private var privacyURL = "https://www.privacypolicies.com/live/1e940f6b-4e5c-438a-a44b-034f70bfd53c"
    @State private var showLoading: Bool = false
    
//    MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            
            PrivacyViewModel(url: URL(string: privacyURL)!, showLoading: $showLoading)
                .overlay(showLoading ? ProgressView("Loading...")
                    .progressViewStyle(.circular)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .tint(.white)
                    .padding()
                    .background(Color(white: 0.2, opacity: 0.7))
                    .foregroundColor(.white)
                    .toAnyView() : EmptyView().toAnyView())
        }
    }
}

//  MARK: - PREVIEW
struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}

//  MARK: - EXTENSION
extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
