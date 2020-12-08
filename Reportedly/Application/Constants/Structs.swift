//
//  Structs.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - Response Helper Structs
struct ResponseError: Error {

    // MARK: - Public Variables
    var message: String
    var statusCode: Int?
    var type: ResponseErrorType

    var string: String { (statusCode ?? 0).description + ": " + message }

    // MARK: - Init Functions
    init(_ type: ResponseErrorType = .other, _ message: String = "", statusCode: Int? = 0) {
        self.message = type == .other ? message : type.message
        self.statusCode = statusCode
        self.type = type
    }
}

struct ResponseSuccess {

    // MARK: - Public Variables
    var type: ResponseSuccessType

    // MARK: - Init Functions
    init(_ type: ResponseSuccessType = .success) {
        self.type = type
    }
}
