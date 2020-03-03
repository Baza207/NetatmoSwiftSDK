//
//  NetatmoManager.swift
//  NetatmoSwiftSDK
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
    
    internal static var shared = NetatmoManager()
    internal static let userDefaultsSuiteName = "com.PigonaHill.NetatmoSwiftSDK.userDefaults.suiteName"
    internal static let userDefaultsKeychainStateUUID = "com.PigonaHill.NetatmoSwiftSDK.userDefaults.stateUUID"
    internal static let keychainServiceName = "com.PigonaHill.NetatmoSwiftSDK.keychain"
    internal static let baseURL = "https://api.netatmo.com"
    internal static let baseOAuth2URL = "\(baseURL)/oauth2"
    internal static let baseAPIURL = "\(baseURL)/api"
    
    // MARK: - Types
    
    internal struct RequestError: Decodable {
        let code: Int
        let message: String
        
        var localizedDescription: String {
            return "RequestError(code: \(code), message: \(message))"
        }
    }
    
    public enum AuthState: Equatable, CustomStringConvertible {
        case unknown
        case authorized
        case tokenExpired
        case unauthorized
        case failed(_ error: Error)
        
        public var description: String {
            switch self {
            case .unknown:
                return "Unknown authentication state"
            case .authorized:
                return "User authorized"
            case .tokenExpired:
                return "Token expired"
            case .unauthorized:
                return "User unauthorized"
            case .failed(let error):
                return "Authentication error: \(error.localizedDescription)"
            }
        }
        
        public static func == (lhs: NetatmoManager.AuthState, rhs: NetatmoManager.AuthState) -> Bool {
            
            switch (lhs, rhs) {
            case (.unknown, .unknown):
                return true
            case (.authorized, .authorized):
                return true
            case (.tokenExpired, .tokenExpired):
                return true
            case (.unauthorized, .unauthorized):
                return true
            case (let .failed(lhError), let .failed(rhError)):
                return lhError.localizedDescription == rhError.localizedDescription
            default:
                return false
            }
        }
    }
    
    // MARK: - Properties
    
    internal var clientId: String = ""
    internal var clientSecret: String = ""
    internal var redirectURI: String = ""
    internal var accessToken: String?
    internal var refreshToken: String?
    internal var expires: Date?
    var isValid: Bool {
        guard let expires = self.expires else { return false }
        return Date() < expires
    }
    internal var requestedScope: [AuthScope]?
    internal var stateUUID: String?
    public var authState: AuthState = .unknown {
        didSet {
            guard oldValue != authState else { return }
            authStateListenerQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                self.authStateDidChangeListeners.values.forEach { (listener) in
                    DispatchQueue.main.async { listener(self.authState) }
                }
            }
        }
    }
    internal lazy var authStateDidChangeListeners = [UUID: ((authState: AuthState) -> Void)]()
    internal let authStateListenerQueue = DispatchQueue(label: "com.PigonaHill.NetatmoSwiftSDK.AuthStateListenerQueue", attributes: .concurrent)
    
    // MARK: - Lifecycle
    
    private init() { }
    
    public static func configure(clientId: String, clientSecret: String, redirectURI: String) {
        
        shared.clientId = clientId
        shared.clientSecret = clientSecret
        shared.redirectURI = redirectURI
        
        guard let stateUUID = shared.loadStateUUID() else {
            do {
                try NetatmoManager.logout()
            } catch {
                shared.authState = .failed(error)
            }
            return
        }
        
        shared.stateUUID = stateUUID
        
        guard let keychainAuthState = try? KeychainPasswordItem(service: NetatmoManager.keychainServiceName, account: stateUUID).readObject() as OAuthState else {
            do {
                try NetatmoManager.logout()
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
        NetatmoManager.refreshToken { (result) in
            
            let authState: AuthState
            switch result {
            case .success:
                authState = .authorized
            case .failure(let error):
                do {
                    try NetatmoManager.logout()
                    authState = .failed(error)
                } catch {
                    authState = .failed(error)
                }
            }
            
            shared.authState = authState
        }
    }
    
    // MARK: - State UUID
    
    internal func loadStateUUID() -> String? {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return nil
        }
        return userDefaults.object(forKey: NetatmoManager.userDefaultsKeychainStateUUID) as? String
    }
    
    @discardableResult
    internal func saveStateUUID(_ uuid: String) -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return false
        }
        
        userDefaults.set(uuid, forKey: NetatmoManager.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
    @discardableResult
    internal func removeStateUUID() -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: NetatmoManager.userDefaultsSuiteName) else {
            return false
        }
        userDefaults.removeObject(forKey: NetatmoManager.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
}
