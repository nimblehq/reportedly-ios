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
    static var userToken: String? {
        get { UserDefaults.standard.string(forKey: "USERDEFAULTSKEY_USERTOKEN") }
        set { UserDefaults.standard.set(newValue, forKey: "USERDEFAULTSKEY_USERTOKEN") }
    }
    
    static var userId: Int? {
        get { UserDefaults.standard.integer(forKey: "USERDEFAULTSKEY_USERID") }
        set { UserDefaults.standard.set(newValue, forKey: "USERDEFAULTSKEY_USERID") }
    }
    
    static var userEmail: String? {
        get { UserDefaults.standard.string(forKey: "USERDEFAULTSKEY_USEREMAIL") }
        set { UserDefaults.standard.set(newValue, forKey: "USERDEFAULTSKEY_USEREMAIL") }
    }
    
    static var userSlackId: String? {
        get { UserDefaults.standard.string(forKey: "USERDEFAULTSKEY_USERSLACKID") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "USERDEFAULTSKEY_USERSLACKID") }
    }
}
