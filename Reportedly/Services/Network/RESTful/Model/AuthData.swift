//
//  AuthData.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct AuthData: Decodable {

    // MARK: - Decodable Enums
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case expireIn = "expires_in"
        case token = "access_token"
    }

    // MARK: - Model Variables
    var createdAt: Double = 0
    var expireIn: Double = 0
    var token = ""

    // MARK: - Public Variables
    var isExpired: Bool { Date(timeIntervalSince1970: createdAt + expireIn) < Date() }
}
