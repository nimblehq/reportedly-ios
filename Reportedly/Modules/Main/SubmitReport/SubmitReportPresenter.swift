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
    
    func didTapSubmitReportButton() {
        guard let taskToday = view?.plansForTodayText, let obstaclesToday = view?.blockingIssuesText else { return }
        view?.dismissKeyboard()
        view?.showLoadingView(message: Localize.moduleLoaderLoadingMessage.localized())
        interactor.submitReport(taskToday: taskToday, obstaclesToday: obstaclesToday)
        log.debug("Submit report button pressed with\ntaskToday: \(taskToday)\nobstaclesToday: \(obstaclesToday)")
    }
    
    func textViewsDidChange() {
        let shouldEnableSubmitReportButton = view?.isValidReport ?? false
        view?.setSubmitReportButtonEnabled(shouldEnableSubmitReportButton)
    }
}

// MARK: - SubmitReportInteractorOutput

extension SubmitReportPresenter: SubmitReportInteractorOutput {
    
    func didSubmitReport() {
        view?.hideLoadingView()
        view?.showSuccessOverlayView { [weak self] in
            self?.router.popViewController()
        }
    }
    
    func didFailToSubmitReport(_ error: ResponseError) {
        view?.hideLoadingView()
        view?.showToastNotification(message: error.message)
    }
}

// MARK: - SubmitReportInput

extension SubmitReportPresenter: SubmitReportInput {
}
