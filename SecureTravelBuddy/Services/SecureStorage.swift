//
//  SecureStorage.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//
import KeychainAccess

class SecureStorage{
    private let keychain = Keychain(service: "com.durvesh.SecureTravelBuddy")
    
    func saveToken(_ token:String){ keychain["auth_token"] = token}
    func getToken() -> String? { return keychain["auth_token"]}
    func clearToken(){ try? keychain.remove("auth_token")}
    
}
