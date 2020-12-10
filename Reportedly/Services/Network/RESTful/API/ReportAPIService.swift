//
//  ReportAPIService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

protocol ReportAPIServiceProtocol {

    func loadReports(with userId: Int, completion: @escaping ResultReportsCompletion)
    
    func submitReport(with submitReportRequest: SubmitReportRequest, completion: @escaping ResultRestfulCompletion)
}

final class ReportAPIService: BaseAPIService, ReportAPIServiceProtocol {

    // MARK: - Public Constants
    
    static let shared = ReportAPIService()

    // MARK: - Public Functions
    
    func loadReports(with userId: Int, completion: @escaping ResultReportsCompletion) {
        request(
            topic: "\(RequestResourceType.reports.rawValue)/\(userId)",
            method: .get
        ) { data, success, error in
            if let error = error {
                return Thread.executeOnMainThread { completion(.failure(error)) }
            }
            guard let success = success else {
                return Thread.executeOnMainThread { completion(.failure(ResponseError(.other))) }
            }
            switch success.type {
            case .noContent: Thread.executeOnMainThread { completion(.success([])) }
            case .success:
                if let data = data, let dataString = String(data: data, encoding: .utf8),
                   let dataDict = dataString.toJSONDictionary?["data"] as? JSONDictionary,
                   let reportsDict = dataDict["data"] as? [JSONDictionary],
                   let reportsData = try? JSONSerialization.data(withJSONObject: reportsDict, options: .prettyPrinted),
                   let reports: [Report] = try? JSONDecoder().decode([Report].self, from: reportsData) {
                    Thread.executeOnMainThread { completion(.success(reports)) }
                } else {
                    Thread.executeOnMainThread { completion(.failure(ResponseError(.wrongJsonFormat))) }
                }
            }
        }
    }
    
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
