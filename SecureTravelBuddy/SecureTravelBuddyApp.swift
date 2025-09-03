//
//  SecureTravelBuddyApp.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import SwiftUI
import Firebase

@main
struct SecureTravelBuddyApp: App {
    //to configer the firebase when app lauched
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
