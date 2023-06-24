//
//  RegisterPasswordTextFieldView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI

struct RegisterPasswordTextFieldView: View {
    //    MARK: - PROPERTIES
        
    @Binding var password: String
        
    //    MARK: - BODY
        var body: some View {
            VStack {
                SecureField("password:", text: $password)
                    .modifier(TextFieldModifier())
                    .keyboardType(.default)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .onChange(of: password) { _ in
                        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
            }
        }
    }

    //  MARK: - PREVIEW
struct RegisterPasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPasswordTextFieldView(password: .constant(""))
    }
}
