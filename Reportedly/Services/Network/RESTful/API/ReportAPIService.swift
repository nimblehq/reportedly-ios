//
//  ReportAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

protocol ReportAPIServiceProtocol {

    func submitReport(with submitReportRequest: SubmitReportRequest, completion: @escaping ResultRestfulCompletion)
}

final class ReportAPIService: BaseAPIService, ReportAPIServiceProtocol {

    // MARK: - Public Constants
    
    static let shared = ReportAPIService()

    // MARK: - Public Functions
    
    func submitReport(with submitReportRequest: SubmitReportRequest, completion: @escaping ResultRestfulCompletion) {
        request(
            topic: RequestResourceType.reports.rawValue,
            method: .post,
            bodyParams: submitReportRequest.toDictionary()
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
}
