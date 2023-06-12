//
//  ForgotPasswordButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordButtonView: View {
    
    @ObservedObject var user: User
    @State var recoveryPassword: Bool = false
    @State private var showingAlert = false
    @State private var errorDescription: String = ""
    @State private var email: String = ""
    
    var body: some View {
        Button("forgot password?") {
            
            forgotButtonTapped()
        }
        .foregroundColor(.accentColor)
        .alert(isPresented: $showingAlert) {
            
            if self.recoveryPassword {
                return Alert(title: Text("Message sent!"), message: Text("Please check your email"), dismissButton: .default(Text("OK")))
                
            } else {
                return Alert(title: Text("Error..."), message: Text("\(errorDescription) \nPlease insert your email in text field"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func forgotButtonTapped() {
        
        Auth.auth().sendPasswordReset(withEmail: user.email) { error in
            // Your code here
            
            if error != nil {
                
                errorDescription = error!.localizedDescription
                print("NO user email \(error!.localizedDescription)")
            } else {
                
                self.recoveryPassword.toggle()
                print("User email is: \(user.email)")
            }
            self.showingAlert.toggle()
        }
    }
}

struct ForgotPasswordButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordButtonView(user: User())
    }
}
