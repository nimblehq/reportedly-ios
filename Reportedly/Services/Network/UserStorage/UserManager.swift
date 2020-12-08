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
    
    // TODO: - Update to get actual token from sever later on
    public var token: Token? { nil }
}
