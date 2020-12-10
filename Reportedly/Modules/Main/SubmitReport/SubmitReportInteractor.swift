//
//  SubmitReportInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SubmitReportInteractorInput: AnyObject {
    
    func submitReport(taskToday: String, obstaclesToday: String)
}

// sourcery: AutoMockable
protocol SubmitReportInteractorOutput: AnyObject {
    
    func didSubmitReport()
    func didFailToSubmitReport(_ error: ResponseError)
}

final class SubmitReportInteractor {

    private let reportAPIService: ReportAPIServiceProtocol
    private let userManager: UserManager
    
    weak var output: SubmitReportInteractorOutput?
    
    init(
        reportAPIService: ReportAPIServiceProtocol,
        userManager: UserManager
    ) {
        self.reportAPIService = reportAPIService
        self.userManager = userManager
    }
}

// MARK: - SubmitReportInteractorInput

extension SubmitReportInteractor: SubmitReportInteractorInput {
    
    func submitReport(taskToday: String, obstaclesToday: String) {
        guard let userId = userManager.user?.id else {
            output?.didFailToSubmitReport(ResponseError(.other))
            return log.error("No logged in user. Cancel the request.")
        }
        reportAPIService.submitReport(
            with: SubmitReportRequest(userId: userId, tasksToday: taskToday, obstaclesToday: obstaclesToday)
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success: self.output?.didSubmitReport()
            case .failure(let error): self.output?.didFailToSubmitReport(error)
            }
        }
    }
}
