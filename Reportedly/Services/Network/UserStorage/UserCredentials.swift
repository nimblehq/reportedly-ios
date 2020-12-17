//
//  UserCredentials.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/15/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct UserCredentials: Codable {
    
    var appToken: Token
    var userId: Int?
}
