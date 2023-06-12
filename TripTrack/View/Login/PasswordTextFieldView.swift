//
//  PasswordTextFieldView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct PasswordTextFieldView: View {
    
//    MARK: - PROPERTIES
    
    @ObservedObject var user = User()
    
//    MARK: - BODY
    
    var body: some View {
        VStack {
            SecureField("password:", text: $user.password)
                .modifier(TextFieldModifier())
                .keyboardType(.default)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
        }
    }
}

//  MARK: - PREVIEW
struct PasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextFieldView()
    }
}
