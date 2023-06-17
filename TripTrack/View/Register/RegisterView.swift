//
//  RegisterView.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

struct RegisterView: View {
//    MARK: - PROPERTIES
    
    let backImage = "back"
    @State private var showLoginView = false
    var title = "Register"
    
    @State var email: String = ""
    @State var password: String = ""
    @State var re_password: String = ""
    
//    MARK: - BODY
    var body: some View {
        ZStack{
            fullBackground(imageName: backImage)
            VStack {
                
                Button("back to login") {
                    
                    self.showLoginView.toggle()
                }
                .fullScreenCover(isPresented: $showLoginView) { LoginView() }
                .foregroundColor(.accentColor)
            }
        }
    }
}

//  MARK: - PREVIEW
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
