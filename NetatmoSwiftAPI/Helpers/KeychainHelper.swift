//
//  KeychainHelper.swift
//  NetatmoSwiftAPI
//
//  Created by James Barrow on 2020-02-13.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

class KeychainHelper {
    
    func set(service: String, account: String, password: String, description: String = "", comment: String = "", label: String? = nil) throws -> Bool {
        
        guard let dataPassword = password.data(using: String.Encoding.utf8) else {
            throw(KeychainError.passwordError)
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrDescription as String: description,
            kSecAttrComment as String: comment,
            kSecAttrLabel as String: label ?? NSNull(),
            kSecAttrAccount as String: account,
            kSecValueData as String: dataPassword
        ]
        
        var err: CFTypeRef?
        let status = SecItemAdd(query as CFDictionary, &err)
        if status == 0 || status == -25299 { // Success or already exisits
            // notify that the save succeeded here
            return true
        } else {
            let errorString = SecCopyErrorMessageString(status, nil) as String? ?? ""
            throw(KeychainError.keychainError(errorString: errorString))
        }
    }
    
    func get(service: String) throws -> (account: String, password: String) {
        
        var item: CFTypeRef? // The returned keychain search item
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        SecItemCopyMatching(getQuery as CFDictionary, &item)
        guard
            let existingItem = item as? [String: Any], // Cast the item to the desired types
            let passwordData = existingItem[kSecValueData as String] as? Data, // Password string as data
            let pass = String(data: passwordData, encoding: String.Encoding.utf8), // Decoded password data to string
            let acc = existingItem[kSecAttrAccount as String] as? String // Account name
        else {
            throw(KeychainError.keychainError(errorString: "Unable to retrieve login due to unknown response from keychain"))
        }
        
        return (acc, pass)
    }
    
    func remove(service: String, description: String = "", comment: String = "", label: String? = nil) throws -> Bool {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrDescription as String: description,
            kSecAttrComment as String: comment,
            kSecAttrLabel as String: label ?? NSNull()
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == 0 {
            return true
        } else {
            let errorString = SecCopyErrorMessageString(status, nil) as String? ?? ""
            throw(KeychainError.keychainError(errorString: errorString))
        }
    }
    
}
