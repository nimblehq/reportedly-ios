//
//  UserDefault+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/11/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - Computed Properties

extension UserDefaults {
    
    static var userCredentials: UserCredentials? {
        get {
            if let data = UserDefaults.standard.value(forKey: "USERDEFAULTSKEY_USERCREDENTIALS") as? Data {
                return try? PropertyListDecoder().decode(UserCredentials.self, from: data)
            }
            return nil
        }
        set {
            let encodedUserCredentials = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedUserCredentials, forKey: "USERDEFAULTSKEY_USERCREDENTIALS")
        }
    }
    
    static var user: User? {
        get {
            if let data = UserDefaults.standard.value(forKey: "USERDEFAULTSKEY_USER") as? Data {
                return try? PropertyListDecoder().decode(User.self, from: data)
            }
            return nil
        }
        set {
            let encodedUser = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedUser, forKey: "USERDEFAULTSKEY_USER")
        }
    }
}
