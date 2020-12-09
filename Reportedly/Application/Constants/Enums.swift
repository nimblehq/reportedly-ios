//
//  Enums.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - Request & Response Enums

enum RequestResourceType: String {
    case signup = "signup"
    case login = "login"
}

enum RequestType {
    case defaultRequest
    case requestWithBody
    case requestWithBodyAndURLParams
}

enum ResponseErrorType {
    case cancelrequest
    case invalidAuthToken
    case noNetwork
    case other
    case timeOut
    case wrongJsonFormat

    var message: String {
        switch self {
        case .cancelrequest: return "Cancel request"
        case .invalidAuthToken: return "Invalid auth token"
        case .noNetwork: return "No network connection"
        case .other: return "Unknown error"
        case .timeOut: return "Request Time Out"
        case .wrongJsonFormat: return "Wrong json format"
        }
    }
}

enum ResponseSuccessType {
    case noContent
    case success

    var message: String {
        switch self {
        case .noContent: return "No response content"
        case .success: return "Success"
        }
    }
}
