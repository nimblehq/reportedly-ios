//
//  SubmitReportPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

final class SubmitReportPresenter {

    private let router: SubmitReportRouterInput
    private let interactor: SubmitReportInteractorInput

    weak var view: SubmitReportViewInput?
    weak var output: SubmitReportOutput?

    init(
        router: SubmitReportRouterInput,
        interactor: SubmitReportInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SubmitReportViewOutput

extension SubmitReportPresenter: SubmitReportViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - SubmitReportInteractorOutput

extension SubmitReportPresenter: SubmitReportInteractorOutput {
}

// MARK: - SubmitReportInput

extension SubmitReportPresenter: SubmitReportInput {
}
