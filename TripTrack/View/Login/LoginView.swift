//
//  LoginView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct LoginView: View {
//    MARK: - PROPERTIES
    
    @ObservedObject var user = User()
    let backImage = "back"
    
//    MARK: - BODY
    var body: some View {
        ZStack {
            fullBackground(imageName: backImage)
            VStack(spacing: 20) {
                LogoView()
                Spacer()
                EmailTextFieldView()
                PasswordTextFieldView()
                LoginButtonView(user: user)
                Spacer()
                HStack(alignment: .bottom) {
                    GoToRegisterButtonView()
                    Spacer()
                    ForgotPasswordButtonView(user: user)
                }
            } .padding(40)
        }
    }
}

//  MARK: - PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
