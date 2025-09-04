//
//  SecureTravelBuddyApp.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct SecureTravelBuddyApp: App {
    //to configer the firebase when app lauched
    init(){
        #if targetEnvironment(simulator)
       // ✅ Must be set BEFORE FirebaseApp.configure()
       let providerFactory = AppCheckDebugProviderFactory()
       AppCheck.setAppCheckProviderFactory(providerFactory)
       #endif
        FirebaseApp.configure()
        print(FirebaseApp.app()?.options.bundleID ?? "No bundle ID found")
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
