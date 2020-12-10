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
}

// MARK: - ReportsHistoryInteractorOutput

extension ReportsHistoryPresenter: ReportsHistoryInteractorOutput {
}

// MARK: - ReportsHistoryInput

extension ReportsHistoryPresenter: ReportsHistoryInput {
}
