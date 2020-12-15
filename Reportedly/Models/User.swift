//
//  User.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

struct User: Codable {
    
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    enum CodingKeys: String, CodingKey {
        case id, email
        case avatarUrl = "avatar_url"
        case slackId = "slack_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
    
    var id: Int = -1
    var avatarUrl: String = ""
    var email: String = ""
    var slackId: String = ""
    var updatedAt: String = ""
    var createdAt: String = ""
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let avatar = try? values.decode(String.self, forKey: .avatarUrl) { avatarUrl = avatar }
        if let created = try? values.decode(String.self, forKey: .createdAt) { createdAt = created }
        if let updated = try? values.decode(String.self, forKey: .updatedAt) { updatedAt = updated }
        slackId = try values.decode(String.self, forKey: .slackId)
        email = try values.decode(String.self, forKey: .email)
        id = try values.decode(Int.self, forKey: .id)
    }
    
    init(id: Int, email: String, slackId: String) {
        self.id = id
        self.email = email
        self.slackId = slackId
    }
}
