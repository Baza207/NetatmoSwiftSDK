//
//  NetatmoManager.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2019-10-23.
//  Copyright © 2019 Pig on a Hill Productions. All rights reserved.
//

import Foundation

/*
 Workflow notes:
 1. Check for UUID in UserDefaults
   a) If found, go to step 2
   b) If not found then create UUID, save to UserDefaults and go to step 3
 2. Fetch tokens from keychain with UUID as account
   a) If found and valid, go to step 7
   b) If not found or invalid, go to step 3
 3. Create auth URL with UUID as state
 4. Call URL in Safari or WebView
 5. Auth callback
 6. Save tokens to keychain with UUID as account
 7. Auth complete
*/

public class NetatmoManager {
    
    public static var shared = NetatmoManager()
    static let userDefaultsSuiteName = "com.PigonaHill.NetatmoSwiftAPI.userDefaults.suiteName"
    static let userDefaultsKeychainStateUUID = "com.PigonaHill.NetatmoSwiftAPI.userDefaults.stateUUID"
    static let keychainServiceName = "com.PigonaHill.NetatmoSwiftAPI.keychain"
    
    // MARK: - Types

    public enum NetatmoError: Error {
        case badURL
        case noData
        case generalError
        case noRefreshToken
        case noAccessToken
        case noCallbackCode
        case noScope
        case stateMismatch
    }

    public enum AuthState: Equatable {
        case unknown
        case authorized
        case tokenExpired
        case failed(_ error: Error)
        
        public static func == (lhs: NetatmoManager.AuthState, rhs: NetatmoManager.AuthState) -> Bool {
            
            switch (lhs, rhs) {
            case (.unknown, .unknown):
                return true
            case (.authorized, .authorized):
                return true
            case (.tokenExpired, .tokenExpired):
                return true
            case (let .failed(lhError), let .failed(rhError)):
                return lhError.localizedDescription == rhError.localizedDescription
            default:
                return false
            }
        }
    }
    
    // MARK: - Properties
    
    var clientId: String = ""
    var clientSecret: String = ""
    var redirectURI: String = ""
    var accessToken: String?
    var refreshToken: String?
    var expires: Date?
    var requestedScope: [AuthScope]?
    var stateUUID: String?
    var authState: AuthState = .unknown {
        didSet {
            guard oldValue != authState else { return }
            authStateDidChangeListeners.values.forEach { $0(authState) }
        }
    }
    lazy var authStateDidChangeListeners = [UUID: ((authState: AuthState) -> Void)]()
    
    // MARK: - Lifecycle
    
    private init() { }
    
    public static func configure(clientId: String, clientSecret: String, redirectURI: String) {
        
        shared.clientId = clientId
        shared.clientSecret = clientSecret
        shared.redirectURI = redirectURI
        
        guard let stateUUID = shared.loadStateUUID() else {
            do {
                try shared.logout()
                shared.authState = .unknown
            } catch {
                shared.authState = .failed(error)
            }
            return
        }
        
        shared.stateUUID = stateUUID
        
        guard let keychainAuthState = try? KeychainPasswordItem(service: NetatmoManager.keychainServiceName, account: stateUUID).readObject() as OAuthState else {
            do {
                try shared.logout()
                shared.authState = .unknown
            } catch {
                shared.authState = .failed(error)
            }
            return
        }
        
        shared.accessToken = keychainAuthState.accessToken
        shared.refreshToken = keychainAuthState.refreshToken
        shared.expires = keychainAuthState.expires
        
        guard keychainAuthState.isValid == false else {
            shared.authState = .authorized
            return
        }
        
        // Attempt tokenn refresh
        shared.refreshToken { (result) in
            
            let authState: AuthState
            switch result {
            case .success:
                authState = .authorized
            case .failure(let error):
                do {
                    try shared.logout()
                    authState = .failed(error)
                } catch {
                    authState = .failed(error)
                }
            }
            
            shared.authState = authState
        }
    }
    
    // MARK: - State UUID
    
    func loadStateUUID() -> String? {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return nil
        }
        return userDefaults.object(forKey: NetatmoManager.userDefaultsKeychainStateUUID) as? String
    }
    
    @discardableResult
    func saveStateUUID(_ uuid: String) -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return false
        }
        
        userDefaults.set(uuid, forKey: NetatmoManager.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
    @discardableResult
    func removeStateUUID() -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return false
        }
        userDefaults.removeObject(forKey: NetatmoManager.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
}
