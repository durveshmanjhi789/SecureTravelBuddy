//
//  LoginView.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToMap = false

    var body:some View{
        
        NavigationStack{
            VStack {
                TextField("Email", text: $email).textFieldStyle(.roundedBorder).textContentType(.emailAddress)
                SecureField("Password", text: $password).textFieldStyle(.roundedBorder)
                Button("Login") {
                    Task { await vm.login(email: email, password: password)
                        if vm.user != nil {
                            navigateToMap = true
                        }
                    }
                   
                }
                Button("Sign Up") {
                    Task { await vm.signup(email: email, password: password)
                        if vm.user != nil {
                            navigateToMap = true
                        }
                    }
                   
                }
                if let error = vm.errorMessage {
                    Text(error).foregroundColor(.red)
                }
               
           
            }.padding()
                .navigationDestination(isPresented: $navigateToMap){
                    MapView()
                }
        }
        
    }
}
