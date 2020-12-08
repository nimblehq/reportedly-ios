//
//  AuthenticationAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

class AuthenticationAPIService: BaseAPIService {

    // MARK: - Public Constants & Variables
    static let shared = AuthenticationAPIService()

    var token: String { authData?.token ?? "" }

    // MARK: - Private Variables
    private var authData: AuthData?

    // MARK: - Public Functions
    func signIn(completion: SuccessCompletion? = nil) {
        // TODO: Add signin API logic here
        completion?(true)
    }
    
    func signUp(completion: SuccessCompletion? = nil) {
        // TODO: Add signup API logic here
        completion?(true)
    }
    
    func refreshToken(completion: SuccessCompletion? = nil) {
        // TODO: Add refreshToken API logic here
        completion?(true)
    }
}
