//
//  RequestInterceptor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

private class Requester {
    var url = ""
    var completions: [ResponseCompletion] = []
    var dataRequest: DataRequest?
}

class RequestInterceptor {

    // MARK: - Callbacks
    let completion: ResponseCompletion

    // MARK: - Public Variables
    let bodyParams: JSONDictionary
    let method: HTTPMethod
    let queryParams: JSONDictionary
    let requestType: RequestType
    let url: String

    // MARK: - Private Variables & Constants
    private static let requestQueue = DispatchQueue(label: "requestQueue", qos: .background)

    private static var requesters: [String: Requester] = [:]
    private var header: HTTPHeaders { HTTPHeaderBuilder.shared.header }

    // MARK: - Init Functions
    init(bodyParams: JSONDictionary, method: HTTPMethod, queryParams: JSONDictionary, requestType: RequestType, url: String, completion: @escaping ResponseCompletion) {
        self.bodyParams = bodyParams
        self.method = method
        self.queryParams = queryParams
        self.requestType = requestType
        self.url = url
        self.completion = completion
    }

    // MARK: - Public Functions
    @discardableResult func makeRequest(retryCount: Int = 0) -> DataRequest? {
        func commonResultHandler(_ result: AFDataResponse<Data?>, completion: @escaping ResponseCompletion) {
            resultHandler(data: result.data, response: result.response, error: result.error, retryCount: retryCount, completion: completion)
        }
        log.info("---------------Making request---------------")
        log.info("URL Requesting... \(url)")
        log.info("Method \(method)")
        log.info("With queryParams \(queryParams)")
        log.info("With bodyParams \(bodyParams)")
        log.info("---------------END---------------")
        switch requestType {
        case .defaultRequest:
            if method == .get {
                RequestInterceptor.requestQueue.async { [weak self] in
                    guard let self = self else { return }

                    // For GET method, we optimize all of the same request (same url and query params)
                    let key = self.url + (self.queryParams as? [String: AnyHashable]).hashValue.description
                    if retryCount == 0, let requester = RequestInterceptor.requesters[key] {
                        requester.completions.append(self.completion)
                    } else {
                        let request = AF.request(self.url, method: self.method, parameters: self.queryParams, headers: self.header) { urlRequest in
                            urlRequest.timeoutInterval = BaseAPIService.DEFAULT_TIMEOUT
                        }.validate().response(queue: RequestInterceptor.requestQueue) {
                            commonResultHandler($0) { [key] data, success, error in
                                RequestInterceptor.requesters[key]?.completions.forEach { $0(data, success, error) }
                                RequestInterceptor.requesters[key] = nil
                            }
                        }
                        let requester = RequestInterceptor.requesters[key] ?? Requester()
                        requester.completions.append(self.completion)
                        requester.dataRequest = request
                        RequestInterceptor.requesters[key] = requester
                    }
                }
                return nil
            }
            return AF.request(url, method: method, parameters: queryParams, headers: header) { urlRequest in
                urlRequest.timeoutInterval = BaseAPIService.DEFAULT_TIMEOUT
            }.validate().response(queue: DispatchQueue.global(qos: .background)) { [weak self] in
                guard let self = self else { return }
                commonResultHandler($0, completion: self.completion)
            }
        case .requestWithBody: return AF.request(url, method: method, parameters: bodyParams, encoding: JSONEncoding.prettyPrinted, headers: header) { urlRequest in
            urlRequest.timeoutInterval = BaseAPIService.DEFAULT_TIMEOUT
        }.validate().response(queue: DispatchQueue.global(qos: .background)) { [weak self] in
                guard let self = self else { return }
                commonResultHandler($0, completion: self.completion)
            }
        case .requestWithBodyAndURLParams:
            var urlComponent = URLComponents(string: url)
            urlComponent?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value as? String ?? "") }
            return AF.request(urlComponent?.url ?? "", method: method, parameters: bodyParams, encoding: JSONEncoding.default, headers: header) { urlRequest in
                urlRequest.timeoutInterval = BaseAPIService.DEFAULT_TIMEOUT
            }.validate().response(queue: DispatchQueue.global(qos: .background)) { [weak self] in
                guard let self = self else { return }
                commonResultHandler($0, completion: self.completion)
            }
        }
    }

    func resultHandler(data: Data?, response: HTTPURLResponse?, error: AFError?, retryCount: Int, completion: @escaping ResponseCompletion) {
        // Return if request is canceled
        guard !(error?.isExplicitlyCancelledError ?? false) else { return completion(nil, nil, ResponseError(.cancelrequest)) }
        guard error?._code != NSURLErrorTimedOut else {
            return completion(nil, nil, ResponseError(.timeOut))
        }

        // Build errorMessage if it is
        var errorMessage = "Unknown Error From Server"

        // Get error message from data response
        if let data = data, let dataDict = String(data: data, encoding: .utf8)?.toJSONDictionary {
            guard !dataDict.keys.isEmpty else {
                log.info("-------------RESPONSE RESULT HAS NO CONTENT-------------")
                log.info("-------------END-------------")
                return completion(nil, ResponseSuccess(.noContent), nil)
            }
            errorMessage = dataDict["message"] as? String ?? ""
        } else {
            log.error("-------------RESPONSE ERROR------------- \(error?.errorDescription ?? "Cannot found data or data cannot be parsed to dictionary")")
            log.error("-------------END-------------")
        }

        if let response = response {
            log.info("-------------RESPONSE RESULT-------------")
            log.info("\(response)")
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                if let dataDict = dataString.toJSONDictionary {
                    print("Data \(dataDict)")
                } else {
                    print("Data array \(dataString.toJSONArray)")
                }
            }
            log.info("-------------END-------------")
        } else {
            log.info("-------------RESPONSE RESULT HAS NO CONTENT-------------")
            log.info("-------------END-------------")
        }

        switch response?.statusCode {
        // Success response from server
        case 200: completion(data, ResponseSuccess(data == nil ? .noContent : .success), nil)

        // Invalid, missing or expired Authentication token
        case 401:
            guard retryCount < BaseAPIService.MAX_REQUEST_RETRY_COUNT else { return completion(nil, nil, ResponseError(.invalidAuthToken)) }

            // Refresh authentication key from server and call restful request again
            AuthenticationAPIService.shared.refreshToken { success in
                if success {
                    // Retry the current request after getting the new authKey
                    self.makeRequest(retryCount: retryCount + 1)
                } else {
                    completion(nil, nil, ResponseError(.invalidAuthToken))
                    return log.error("Failed to get new token")
                }
            }

        // Other unhandled errors
        default: completion(nil, nil, ResponseError(.other, errorMessage, statusCode: response?.statusCode))
        }
    }
}
