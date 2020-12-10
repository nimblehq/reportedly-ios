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
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
    
    var id: Int = -1
    var email: String = ""
    var slackId: String = ""
    var updatedAt: String = ""
    var createdAt: String = ""
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let updated = try? values.decode(String.self, forKey: .updatedAt) { updatedAt = updated }
        if let created = try? values.decode(String.self, forKey: .createdAt) { createdAt = created }
        slackId = try values.decode(String.self, forKey: .slackId)
        email = try values.decode(String.self, forKey: .email)
        id = try values.decode(Int.self, forKey: .id)
    }
}
