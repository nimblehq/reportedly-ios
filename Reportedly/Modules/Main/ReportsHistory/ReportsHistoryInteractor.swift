//
//  ReportsHistoryInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol ReportsHistoryInteractorInput: AnyObject {
    
    func loadReports()
}

// sourcery: AutoMockable
protocol ReportsHistoryInteractorOutput: AnyObject {
    
    func didLoadReports(reports: [Report])
    func didFailToLoadReports(_ error: ResponseError)
}

final class ReportsHistoryInteractor {

    private let reportAPIService: ReportAPIServiceProtocol
    private let userManager: UserManager
    
    weak var output: ReportsHistoryInteractorOutput?
    
    init(
        reportAPIService: ReportAPIServiceProtocol,
        userManager: UserManager
    ) {
        self.reportAPIService = reportAPIService
        self.userManager = userManager
    }
}

// MARK: - ReportsHistoryInteractorInput

extension ReportsHistoryInteractor: ReportsHistoryInteractorInput {
    
    func loadReports() {
        guard let userId = userManager.user?.id else {
            output?.didFailToLoadReports(ResponseError(.other))
            return log.error("No logged in user. Cancel the request.")
        }
        reportAPIService.loadReports(with: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reports): self.output?.didLoadReports(reports: reports)
            case .failure(let error): self.output?.didFailToLoadReports(error)
            }
        }
    }
}
