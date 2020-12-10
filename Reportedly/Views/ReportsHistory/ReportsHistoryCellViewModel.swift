//
//  AccountRecoveryVerifyMethodCellViewModel.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct ReportsHistoryCellViewModel {

    var reportDate: Date = Date.init(timeIntervalSince1970: 0)
    var reportTasksTitle: String = ""
    var reportTasksContent: String = ""
    var reportObstaclesTitle: String = ""
    var reportObstaclesContent: String = ""

    init(date: Date, tasks: String, obstacles: String) {
        reportDate = date
        reportTasksTitle = Localize.moduleReportsHistoryCellReportTasksTitle.localized()
        reportTasksContent = tasks
        reportObstaclesTitle = Localize.moduleReportsHistoryCellReportObstaclesTitle.localized()
        reportObstaclesContent = obstacles
    }
}
