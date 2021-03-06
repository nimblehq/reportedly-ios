//
//  SignupRequest.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct SignupRequest: Encodable {
    
    // MARK: - Request Variables
    
    let email: String
    let password: String
    let passwordConfirmation: String
    let slackId: String
}

extension SignupRequest {
    
    enum CodingKeys: String, CodingKey {
        case email = "user[email]"
        case password = "user[password]"
        case passwordConfirmation = "user[password_confirmation]"
        case slackId = "user[slack_id]"
    }
}
