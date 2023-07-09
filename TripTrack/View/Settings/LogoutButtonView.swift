//
//  LogoutButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-16.
//

import SwiftUI

struct LogoutButtonView: View {
    //    MARK: - PROPERTIES
    
    @State private var showLoginView = false
    @State private var showingAlert = false
    
    //    MARK: - BODY
    var body: some View {
        
        VStack {
            ZStack {
                Button {
                    
                    showingAlert.toggle()
                    
                } label: {
                    
                    VStack {
                        Image(systemName: "figure.run.square.stack")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        Text("log out")
                            .font(.caption2)
                    } .foregroundColor(Color("projectNav"))
                }
                .alert("Do you really want to sign out?", isPresented: $showingAlert) {
                    
                    Button("Sign out", role: .destructive, action: {
                        
                        self.showLoginView.toggle()
                        Utilities.logOut()
                    })
                    
                    Button("Cancel", role: .cancel, action: {})
                }
                .fullScreenCover(isPresented: $showLoginView) { LoginView() }
            }
        }
    }
}

//  MARK: - PREVIEW
struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
    }
}
