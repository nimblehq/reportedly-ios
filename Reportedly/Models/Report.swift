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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
        attributes = try values.decode(ReportAttributes.self, forKey: .attributes)
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        obstaclesToday = try values.decode(String.self, forKey: .obstaclesToday)
        taskToday = try values.decode(String.self, forKey: .taskToday)
        user = try values.decode(User.self, forKey: .user)
    }
}
