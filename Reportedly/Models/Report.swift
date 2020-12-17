//
//  Report.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct Report: Decodable {
    
    // MARK: - Decodable Enums
    
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    enum CodingKeys: String, CodingKey {
        case id, type, attributes
    }
    
    var id: String = ""
    var type: String = ""
    var attributes: ReportAttributes
    
    var obstacles: String {
        attributes.obstaclesToday
    }
    var tasks: String {
        attributes.taskToday
    }
    var date: Date {
        attributes.user.createdAt.toDate(withFormat: DateFormat.yyyy_MM_dd_T_HH_mm_ss_SSSZ)
    }
}

struct ReportAttributes: Decodable {
    
    // MARK: - Decodable Enums
    
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    enum CodingKeys: String, CodingKey {
        case id, user
        case obstaclesToday = "obstacles_today"
        case taskToday = "task_today"
    }
    
    var id: Int = 0
    var obstaclesToday: String = ""
    var taskToday: String = ""
    var user: User
}
