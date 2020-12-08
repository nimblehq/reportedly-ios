//
//  SubmitReportService.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Alamofire

final class SubmitReportService: BaseAPIService {

    // MARK: - Public Constants
    
    static let shared = SubmitReportService()

    // MARK: - Public Functions
    
    func submitReport(completion: SuccessCompletion? = nil) {
        // TODO: Add submit API logic here
        completion?(true)
    }
}
