//
//  LoginButtonView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI
import FirebaseAuth

struct LoginButtonView: View {
    
//    MARK: - PROPERTIES
    
    var user: User
    @State private var showingAlert = false
    @State private var showMainView = false
    @State private var errorDescription: String = ""
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    
//    MARK: - BODY
    
    var body: some View {
        Button {
            
            checkUser()
            hideKeyboard()
            
        } label: {
            Text("sign in")
                .modifier(ActionButtonModifier())
        }
        .alert(isPresented: self.$showingAlert) { Alert(title: Text("Error..."), message: Text("\(errorDescription)"), dismissButton: .default(Text("OK"))) }
        .fullScreenCover(isPresented: $showMainView) { MainView() }
    }
    
    func checkUser(){
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
            
            if error != nil {
                
                self.showingAlert.toggle()
                self.errorDescription = error!.localizedDescription
                notificationGenerator.notificationOccurred(.error)
            } else {
                
                notificationGenerator.notificationOccurred(.success)
                showMainView.toggle()
                print("User logged in \(user.email)")
            }
        }
    }
}

//  MARK: - PREVIEW

struct LoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonView(user: User())
    }
}
