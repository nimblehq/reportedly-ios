//
//  AuthenticationAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

protocol AuthenticationAPIServiceProtocol {

    func signUp(with signupRequest: SignupRequest, completion: @escaping ResultRestfulCompletion)
}

final class AuthenticationAPIService: BaseAPIService, AuthenticationAPIServiceProtocol {

    // MARK: - Public Constants & Variables
    
    static let shared = AuthenticationAPIService()

    var token: String { tokenData?.value ?? "" }

    // MARK: - Private Variables
    
    private var tokenData: Token?

    // MARK: - Public Functions
    
    func signIn(completion: SuccessCompletion? = nil) {
        // TODO: Add signin API logic here
        completion?(true)
    }
    
    func signUp(with signupRequest: SignupRequest, completion: @escaping ResultRestfulCompletion) {
        request(
            topic: RequestResourceType.signup.rawValue,
            method: .post,
            bodyParams: signupRequest.toDictionary()
        ) { data, success, error in
            Thread.executeOnMainThread {
                if let error = error {
                    return completion(.failure(error))
                }
                guard let success = success else {
                    return completion(.failure(ResponseError(.other)))
                }
                switch success.type {
                case .noContent: completion(.success(ResponseSuccess(.noContent)))
                case .success: completion(.success(ResponseSuccess(.success)))
                }
            }
        }
    }
    
    func refreshToken(completion: SuccessCompletion? = nil) {
        // TODO: Add refreshToken API logic here
        completion?(true)
    }
}
