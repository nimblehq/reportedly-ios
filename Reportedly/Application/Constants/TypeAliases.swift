//
//  TypeAliases.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// MARK: - Completion Typealiases

typealias Completion<T>             = (T) -> Void
typealias EmptyCompletion           = () -> Void
typealias ResultRestfulCompletion   = (Result<ResponseSuccess, ResponseError>) -> Void
typealias ResponseCompletion        = (_ data: Data?, _ success: ResponseSuccess?, _ error: ResponseError?) -> Void
typealias StringCompletion          = (String) -> Void
typealias SuccessCompletion         = (Bool) -> Void
typealias ResultUserCompletion      = (Result<User, ResponseError>) -> Void

// MARK: - DataType Typealiases

typealias JSONDictionary         = [String: Any]

// MARK: - R.Swift Typealiases

typealias Asset = R.image
typealias Localize = R.string.localizable
