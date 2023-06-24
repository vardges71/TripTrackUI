//
//  DeleteAccountButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-16.
//

import SwiftUI

struct DeleteAccountButtonView: View {
    
//    MARK: - PROPERTIES
    
    @State private var showRegisterView = false
    @State private var showingAlert = false
    
    //    MARK: - BODY
    var body: some View {
        
        VStack {
            ZStack {
                Button {
                    
                    showingAlert.toggle()
                    
                } label: {
                    
                    VStack {
                        Image(systemName: "trash.square")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        Text("delete account")
                            .font(.caption2)
                    } .foregroundColor(.accentColor)
                }
                .actionSheet(isPresented: $showingAlert) {
                    ActionSheet(
                        title: Text("Do you really want to delete your account?"),
                        buttons: [
                    
                            .destructive(Text("Delete")) {
                                
                                Utilities.deleteAccount()
                                self.showRegisterView.toggle()
                            },
                            .cancel(Text("Cancel")) {}
                        ]
                    )
                }
                .fullScreenCover(isPresented: $showRegisterView) { ContentView() }
            }
        }
    }
}

struct DeleteAccountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountButtonView()
    }
}
