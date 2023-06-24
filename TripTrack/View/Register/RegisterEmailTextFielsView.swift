//
//  RegisterEmailTextFielsView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI

struct RegisterEmailTextFielsView: View {
    //    MARK: - PROPERTIES
        
    @Binding var email: String
        
    //    MARK: - BODY
        var body: some View {
            
            VStack {
                TextField("e-mail:", text: $email)
                    .modifier(TextFieldModifier())
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .onChange(of: email) { _ in
                        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
            }
        }
    }

    //  MARK: - PREVIEW
struct RegisterEmailTextFielsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailTextFielsView(email: .constant(""))
    }
}
