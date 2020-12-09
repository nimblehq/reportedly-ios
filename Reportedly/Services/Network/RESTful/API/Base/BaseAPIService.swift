//
//  BaseAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

class BaseAPIService {

    // MARK: - Public Constants & Variables
    
    static let DEFAULT_TIMEOUT: TimeInterval = 20
    static let MAX_REQUEST_RETRY_COUNT       = 3
    static let PAGE_SIZE                     = 10
    static let SERVER_DOMAIN                 = "https://reportedly-staging.herokuapp.com/api/v1"

    // MARK: - Managers
    
    lazy var reachabilityManager = ReachabilityManager.shared

    // MARK: - Public Functions
    
    @discardableResult func request(
        topic: String = "",
        method: HTTPMethod = .get,
        bodyParams: JSONDictionary = [:],
        queryParams: JSONDictionary = [:],
        shouldAuthenticate: Bool = true,
        completion: @escaping ResponseCompletion
    ) -> DataRequest? {

        // Stop the request immediately and returns no network error
        guard reachabilityManager.hasInternet else {
            completion(nil, nil, ResponseError(.noNetwork))
            return nil
        }

        // Don't execute the actual request call to server when running unit tests
        guard NSClassFromString("XCTest") == nil else {
            completion(nil, nil, ResponseError(.other))
            return nil
        }

        // Execute the request
        let requestType: RequestType = (!bodyParams.isEmpty && !queryParams.isEmpty)
            ? .requestWithBodyAndURLParams
            : !bodyParams.isEmpty
            ? .requestWithBody
            : .defaultRequest
        return RequestInterceptor(
            bodyParams: bodyParams,
            method: method,
            queryParams: queryParams,
            requestType: requestType,
            shouldAuthenticate: shouldAuthenticate,
            url: url(with: topic),
            completion: completion
        ).makeRequest()
    }

    func url(with topic: String) -> String {
        [BaseAPIService.SERVER_DOMAIN, topic].joined(separator: "/")
    }
}
