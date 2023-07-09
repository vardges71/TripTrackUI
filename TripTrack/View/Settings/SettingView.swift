//
//  SettingView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-16.
//

import SwiftUI

struct SettingView: View {
    //    MARK: - PROPERTIES
    
    @Binding var isSettingsVisible: Bool
    
    //    MARK: - BODY
    var body: some View {
        
        HStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.accentColor)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .padding()
                .overlay {
                    HStack {
                        
                        Spacer()
                        AboutViewButton()
                        Spacer()
                        LogoutButtonView()
                        Spacer()
                        DeleteAccountButtonView()
                        Spacer()
                        
                    }
                }
        }.opacity(isSettingsVisible ? 1 : 0)
                .transition(.scale)
    }
}

//  MARK: - PREVIEW
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isSettingsVisible: .constant(false))
    }
}
