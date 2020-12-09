//
//  LoginRequest.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct LoginRequest: Encodable {
    
    // MARK: - Request Variables
    
    let email: String
    let password: String
}

extension LoginRequest {
    
    enum CodingKeys: String, CodingKey {
        case email = "user[email]"
        case password = "user[password]"
    }
}
