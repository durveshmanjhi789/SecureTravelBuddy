//
//  AuthViewModel.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import Foundation
import FirebaseAuth
import KeychainAccess

//you are telling Swift that all properties and methods inside this class should run on the main thread.
@MainActor

class AuthViewModel:ObservableObject{
    @Published var user:User?
    @Published var errorMessage:String?
    let storage = SecureStorage()
    func login(email:String,password:String) async {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            self.user = User(id: result.user.uid, email: result.user.email ?? "", name: result.user.displayName ?? "")
            
            if let token = result.user.refreshToken {
                storage.saveToken(token)
            }
           
        }catch{
            debugPrint(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signup(email:String,password:String) async{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.user = User(id: result.user.uid, email: result.user.email ?? "", name: result.user.displayName ?? "")
            if let token = result.user.refreshToken {
                storage.saveToken(token)
            }

        }catch{
            let nsError = error as NSError
            debugPrint("Firebase Auth error:", nsError)
            debugPrint(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func logout(){
        try? Auth.auth().signOut()
        storage.clearToken()
        user = nil
    }
    
}
