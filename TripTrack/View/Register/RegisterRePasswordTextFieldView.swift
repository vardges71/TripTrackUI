//
//  RegisterRePasswordTextFieldView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI

struct RegisterRePasswordTextFieldView: View {
    //    MARK: - PROPERTIES
    
    @Binding var re_password: String
    
    //    MARK: - BODY
    var body: some View {
        VStack {
            SecureField("confirm password:", text: $re_password)
                .modifier(TextFieldModifier())
                .keyboardType(.default)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .onChange(of: re_password) { _ in
                    re_password = re_password.trimmingCharacters(in: .whitespacesAndNewlines)
                }
        }
    }
}

//  MARK: - PREVIEW
struct RegisterRePasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterRePasswordTextFieldView(re_password: .constant(""))
    }
}
