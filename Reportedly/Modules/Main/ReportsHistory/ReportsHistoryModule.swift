//
//  ReportsHistoryModule.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol ReportsHistoryInput: AnyObject {
}

// sourcery: AutoMockable
protocol ReportsHistoryOutput: AnyObject {
}

final class ReportsHistoryModule {

    let view: ReportsHistoryViewController
    let presenter: ReportsHistoryPresenter
    let router: ReportsHistoryRouter
    let interactor: ReportsHistoryInteractor

    var output: ReportsHistoryOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: ReportsHistoryInput { presenter }

    init() {
        view = ReportsHistoryViewController()
        router = ReportsHistoryRouter()
        interactor = ReportsHistoryInteractor()
        presenter = ReportsHistoryPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
