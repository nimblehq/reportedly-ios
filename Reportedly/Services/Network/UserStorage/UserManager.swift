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
            UserDefaults.userToken = token?.value
        }
    }
    
    public var user: User? {
        didSet {
            UserDefaults.userId = user?.id
            UserDefaults.userEmail = user?.email
            UserDefaults.userSlackId = user?.slackId
        }
    }
    
    func cleanupUserSession() {
        token = nil
        user = nil
    }
}
