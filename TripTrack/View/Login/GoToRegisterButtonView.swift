//
//  GoToRegisterButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct GoToRegisterButtonView: View {
//    MARK: - PROPERTIES
    
    @State private var showRegView = false
    
    
//    MARK: - BODY
    var body: some View {
        Button("register") {
            
            self.showRegView.toggle()
        }
        .foregroundColor(.accentColor)
        .fullScreenCover(isPresented: $showRegView) { RegisterView() }
    }
}

//  MARK: - PREVIEW

struct GoToRegisterButtonView_Previews: PreviewProvider {

    static var previews: some View {
        GoToRegisterButtonView()
    }
}
