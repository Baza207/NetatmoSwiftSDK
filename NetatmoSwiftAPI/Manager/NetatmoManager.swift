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
    internal static let userDefaultsSuiteName = "com.PigonaHill.NetatmoSwiftAPI.userDefaults.suiteName"
    internal static let userDefaultsKeychainStateUUID = "com.PigonaHill.NetatmoSwiftAPI.userDefaults.stateUUID"
    internal static let keychainServiceName = "com.PigonaHill.NetatmoSwiftAPI.keychain"
    
    // MARK: - Types
    
    internal struct RequestError: Decodable {
        public let code: Int
        public let message: String
        
        public var localizedDescription: String {
            return "RequestError(code: \(code), message: \(message))"
        }
    }
    
    public enum NetatmoError: Error, LocalizedError {
        case badURL
        case noData
        case generalError
        case noRefreshToken
        case noAccessToken
        case noCallbackCode
        case noScope
        case stateMismatch
        case error(code: Int, message: String)
        
        public var errorDescription: String? {
            
            switch self {
            case .badURL:
                return "Bad URL"
            case .noData:
                return "No Data"
            case .generalError:
                return "General Error"
            case .noRefreshToken:
                return "No Refresh Token"
            case .noAccessToken:
                return "No Access Token"
            case .noCallbackCode:
                return "No Callback Code"
            case .noScope:
                return "No Scope"
            case .stateMismatch:
                return "State Mismatch"
            case .error(let code, let message):
                return "\(message) [\(code)]"
            }
        }
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
                self.authStateDidChangeListeners.values.forEach { $0(self.authState) }
            }
        }
    }
    internal lazy var authStateDidChangeListeners = [UUID: ((authState: AuthState) -> Void)]()
    internal let authStateListenerQueue = DispatchQueue(label: "com.PigonaHill.NetatmoSwiftAPI.AuthStateListenerQueue", attributes: .concurrent)
    
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
