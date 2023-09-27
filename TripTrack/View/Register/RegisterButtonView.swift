//
//  RegisterButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-24.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct RegisterButtonView: View {
    //    MARK: - PROPERTIES
    
    @State private var showingAlert = false
    @State private var showMainView = false
    @State private var errorDescription: String = ""
    
    @Binding var fullName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var re_password: String
    
    @State var alertType: RegAlerts? = nil
    
    //    MARK: - BODY
    var body: some View {
        
        Button {
            
            hideKeyboard()
            validateFields()
        } label: {
            Text("sign on")
                .modifier(ActionButtonModifier())
        }
        .fullScreenCover(isPresented: $showMainView) { MainView() }
        .alert(isPresented: $showingAlert, content: {
            getAlert()
        })
    }
    
    func getAlert() -> Alert {
        
        switch alertType {
            
        case .isFullNameEmpty:
            return Alert(title: Text("Error..."), message: Text("Full name must be provided"), dismissButton: .default(Text("OK")))
        case .isEmailEmpty:
            return Alert(title: Text("Error..."), message: Text("Email must be provided"), dismissButton: .default(Text("OK")))
        case .isPasswordValid:
            return Alert(title: Text("Error..."), message: Text("Please make sure your password is at least 8 characters, contains a special character and number"), dismissButton: .default(Text("OK")))
        case .isPasswordsNotSame:
            return Alert(title: Text("Error..."), message: Text("Please enter the same password in the \"password\" and \"confirm password\" fields"), dismissButton: .default(Text("OK")))
        case .success:
            return Alert(title: Text("Success..."), message: Text("You are successfully registered!"), dismissButton: .default(Text("OK"), action: {
                registerUser()
                showMainView.toggle()
            }))
        default:
            return Alert(title: Text(""))
        }
    }
    
    func validateFields() {
        
        if fullName.isEmpty {
            
            alertType = .isFullNameEmpty
            showingAlert.toggle()
        }
        else if email.isEmpty {
            
            alertType = .isEmailEmpty
            showingAlert.toggle()
        }
        else if Utilities.isPasswordValid(password) == false || password.isEmpty {
            
            alertType = .isPasswordValid
            showingAlert.toggle()
        }
        else if password != re_password {
            
            alertType = .isPasswordsNotSame
            showingAlert.toggle()
        }
        else {
            
            alertType = .success
            showingAlert.toggle()
        }
    }
    
    func registerUser() {
        
        if showingAlert {
            
        } else {
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    
                    errorDescription = error!.localizedDescription
                    print("ERROR!!! \(errorDescription)")
                    print("USER DATA: \(email) \(password)")
                } else {
                    
                    let db: DatabaseReference!
                    db = Database.database().reference(withPath: "users").child(result!.user.uid).child("credentials")
                    
                    db.setValue(["fullname" : fullName, "email" : email]) { (result, err) in
                        
                    }
                }
            }
            
            
        }
    }
}

//  MARK: - PREVIEW
struct RegisterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterButtonView(fullName: .constant(""), email: .constant(""), password: .constant(""), re_password: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
