//
//  SubmitReportModule.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SubmitReportInput: AnyObject {
}

// sourcery: AutoMockable
protocol SubmitReportOutput: AnyObject {
}

final class SubmitReportModule {

    let view: SubmitReportViewController
    let presenter: SubmitReportPresenter
    let router: SubmitReportRouter
    let interactor: SubmitReportInteractor

    var output: SubmitReportOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: SubmitReportInput { presenter }

    init() {
        view = SubmitReportViewController()
        router = SubmitReportRouter()
        interactor = SubmitReportInteractor()
        presenter = SubmitReportPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
