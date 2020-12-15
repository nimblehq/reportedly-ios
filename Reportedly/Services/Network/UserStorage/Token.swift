//
//  Token.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/3/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// TODO: - Update to get actual token and calculate isExpired flag from sever later on
struct Token: Codable {
    
    var value: String = ""
    var isExpired: Bool = false
}
