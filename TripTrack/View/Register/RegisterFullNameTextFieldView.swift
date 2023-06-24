//
//  RegisterFullNameTextFieldView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI

struct RegisterFullNameTextFieldView: View {
    //    MARK: - PROPERTIES
    
    @Binding var fullName: String
    
    //    MARK: - BODY
    var body: some View {
        
        VStack {
            TextField("full name:", text: $fullName)
                .modifier(TextFieldModifier())
                .keyboardType(.default)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }
}

//  MARK: - PREVIEW
struct RegisterFullNameTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFullNameTextFieldView(fullName: .constant(""))
    }
}
