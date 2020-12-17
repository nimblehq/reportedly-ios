//
//  AuthenticationAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

protocol AuthenticationAPIServiceProtocol {

    func login(with loginRequest: LoginRequest, completion: @escaping ResultCompletion<User>)
    
    func signUp(with signupRequest: SignupRequest, completion: @escaping ResultRestfulCompletion)
}

final class AuthenticationAPIService: BaseAPIService, AuthenticationAPIServiceProtocol {

    // MARK: - Public Constants & Variables
    
    static let shared = AuthenticationAPIService()

    var token: String {
        get {
            UserManager.shared.token?.value ?? ""
        }
        set {
            UserManager.shared.token = Token(value: newValue, isExpired: false)
        }
    }

    // MARK: - Public Functions
    
    func login(with loginRequest: LoginRequest, completion: @escaping ResultCompletion<User>) {
        request(
            topic: RequestResourceType.login.rawValue,
            method: .post,
            bodyParams: loginRequest.toDictionary(),
            shouldAuthenticate: false
        ) { data, success, error in
            if let error = error {
                return Thread.executeOnMainThread { completion(.failure(error)) }
            }
            guard let success = success else {
                return Thread.executeOnMainThread { completion(.failure(ResponseError(.other))) }
            }
            switch success.type {
            case .noContent: Thread.executeOnMainThread { completion(.failure(ResponseError(.wrongJsonFormat))) }
            case .success:
                if let data = data,
                   let userData: UserData = try? JSONDecoder().decode(UserData.self, from: data) {
                    Thread.executeOnMainThread { completion(.success(userData.data)) }
                } else {
                    Thread.executeOnMainThread { completion(.failure(ResponseError(.wrongJsonFormat))) }
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
            if let error = error {
                return Thread.executeOnMainThread { completion(.failure(error)) }
            }
            guard let success = success else {
                return Thread.executeOnMainThread { completion(.failure(ResponseError(.other))) }
            }
            switch success.type {
            case .noContent: Thread.executeOnMainThread { completion(.success(ResponseSuccess(.noContent))) }
            case .success: Thread.executeOnMainThread { completion(.success(ResponseSuccess(.success))) }
            }
        }
    }
    
    func refreshToken(completion: SuccessCompletion? = nil) {
        // TODO: Add refreshToken API logic here
        completion?(false)
    }
}
