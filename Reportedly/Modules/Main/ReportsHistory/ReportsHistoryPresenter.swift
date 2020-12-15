//
//  ReportsHistoryPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

final class ReportsHistoryPresenter {

    private let router: ReportsHistoryRouterInput
    private let interactor: ReportsHistoryInteractorInput

    weak var view: ReportsHistoryViewInput?
    weak var output: ReportsHistoryOutput?

    init(
        router: ReportsHistoryRouterInput,
        interactor: ReportsHistoryInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ReportsHistoryViewOutput

extension ReportsHistoryPresenter: ReportsHistoryViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
    
    func viewWillAppear() {
        triggerLoadReportAction()
    }
    
    func didTapRefreshRightNavBarButtonItem() {
        triggerLoadReportAction()
    }
    
    private func triggerLoadReportAction() {
        view?.showLoadingView(message: Localize.moduleLoaderGettingReportsMessage.localized())
        view?.hideNoReportLabel()
        interactor.loadReports()
    }
}

// MARK: - ReportsHistoryInteractorOutput

extension ReportsHistoryPresenter: ReportsHistoryInteractorOutput {
    
    func didLoadReports(reports: [Report]) {
        view?.hideLoadingView()
        view?.update(with: reports)
    }
    
    func didFailToLoadReports(_ error: ResponseError) {
        view?.hideLoadingView()
        view?.update(with: [])
        view?.showToastNotification(message: error.message)
    }
    
}

// MARK: - ReportsHistoryInput

extension ReportsHistoryPresenter: ReportsHistoryInput {
}
