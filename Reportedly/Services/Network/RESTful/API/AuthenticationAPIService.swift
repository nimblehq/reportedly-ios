//
//  AuthenticationAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

protocol AuthenticationAPIServiceProtocol {

    func login(with loginRequest: LoginRequest, completion: @escaping ResultRestfulCompletion)
    
    func signUp(with signupRequest: SignupRequest, completion: @escaping ResultRestfulCompletion)
}

final class AuthenticationAPIService: BaseAPIService, AuthenticationAPIServiceProtocol {

    // MARK: - Public Constants & Variables
    
    static let shared = AuthenticationAPIService()

    var token: String { tokenData?.value ?? "" }

    // MARK: - Private Variables
    
    // TODO: - Removed this hard-coded authentication token when server support user's token
    private var tokenData: Token? = Token(
        value: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMiIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTYwNzMzMjUyNCwiZXhwIjoxNjA3NDE4OTI0LCJqdGkiOiI0NzVmNzE5ZS02ZTNmLTRmYTUtYjI3Zi02ZDkxMGM5NGRiMzgifQ.l9mFj8r8tfjk0oVyBPKy5HEvBItFzZ-iIlAjcAmKuhA",
        isExpired: true
    )

    // MARK: - Public Functions
    
    func login(with loginRequest: LoginRequest, completion: @escaping ResultRestfulCompletion) {
        request(
            topic: RequestResourceType.login.rawValue,
            method: .post,
            bodyParams: loginRequest.toDictionary(),
            shouldAuthenticate: false
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
    
    func signUp(with signupRequest: SignupRequest, completion: @escaping ResultRestfulCompletion) {
        request(
            topic: RequestResourceType.signup.rawValue,
            method: .post,
            bodyParams: signupRequest.toDictionary(),
            shouldAuthenticate: false
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
