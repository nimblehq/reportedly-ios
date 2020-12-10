//
//  AuthenticationAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

protocol AuthenticationAPIServiceProtocol {

    func login(with loginRequest: LoginRequest, completion: @escaping ResultUserCompletion)
    
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

    // MARK: - Private Variables
    

    // MARK: - Public Functions
    
    func login(with loginRequest: LoginRequest, completion: @escaping ResultUserCompletion) {
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
                if let data = data, let dataString = String(data: data, encoding: .utf8),
                   let userDict = dataString.toJSONDictionary?["data"] as? JSONDictionary,
                   let userData = try? JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted),
                   let user: User = try? JSONDecoder().decode(User.self, from: userData) {
                    Thread.executeOnMainThread { completion(.success(user)) }
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
        completion?(true)
    }
}
