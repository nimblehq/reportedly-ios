//
//  User.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

struct User: Decodable {
    
    // MARK: - Decodable Enums
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    enum CodingKeys: String, CodingKey {
        case id, email
        case slackId = "slack_id"
    }
    
    var id: Int = 0
    var email: String = ""
    var slackId: String = ""
}
