//
//  UserManager.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/3/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    public var token: Token? {
        didSet {
            if let token = token {
                UserDefaults.userCredentials = UserCredentials(appToken: token, userId: user?.id)
            } else {
                UserDefaults.userCredentials = nil
            }
        }
    }
    
    public var user: User? {
        didSet {
            UserDefaults.user = user
        }
    }
    
    func cleanupUserSession() {
        token = nil
        user = nil
    }
}
