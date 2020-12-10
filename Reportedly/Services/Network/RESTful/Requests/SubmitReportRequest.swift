//
//  SubmitReportRequest.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct SubmitReportRequest: Encodable {
    
    // MARK: - Request Variables
    
    let userId: Int
    let tasksToday: String
    let obstaclesToday: String
}

extension SubmitReportRequest {
    
    enum CodingKeys: String, CodingKey {
        case userId = "report[user_id]"
        case tasksToday = "report[task_today]"
        case obstaclesToday = "report[obstacles_today]"
    }
}
