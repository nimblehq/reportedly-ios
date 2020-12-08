//
//  SignupRequest.swift
//  Reportedly
//
//  Created by Minh Pham on 08/12/2020.
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
