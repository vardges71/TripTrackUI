//
//  Styles.swift
//  TripTrack
//
//  Created by Vardges Gasparyan on 2023-06-11.
//

import SwiftUI

public extension View {
    
    func fullBackground(imageName: String) -> some View {
        
        GeometryReader { proxy in
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
        }.ignoresSafeArea()
    }
    
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        
        return self
    }
    
    func hideKeyboard() {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func vehicleInfoSection(label: String, result: String) -> some View {
        
        VStack(alignment: .leading) {
            Text(label)
                .modifier(LabelTextModifier())
            Text(result)
                .textCase(.uppercase)
        }
    }
}

struct TextFieldModifier: ViewModifier {
    
    
    func body(content: Content) -> some View {
        
        content
            .padding()
            .foregroundColor(.accentColor)
            .background(.clear)
            .frame(width: UIScreen.main.bounds.width - 40, height: 44)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
    }
}

struct LabelTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .foregroundColor(Color("projectLabel"))
            .font(.system(size: 13))
    }
}

struct ActionButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .frame(width: UIScreen.main.bounds.width - 40, height: 44, alignment: .center)
            .font(.system(size: 17.0))
            .background(Color.accentColor)
            .foregroundColor(Color("projectNav"))
            .overlay(
                RoundedRectangle(cornerRadius: 5.0).stroke(lineWidth: 2)
            )
    }
}
