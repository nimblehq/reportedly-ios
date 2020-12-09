//
//  HomePresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

final class HomePresenter {

    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput

    weak var view: HomeViewInput?
    weak var output: HomeOutput?

    init(
        router: HomeRouterInput,
        interactor: HomeInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {
    
    func viewWillAppear() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.MMM_d_YYYY
        dateFormatter.locale = Locale(identifier: LanguageSystem.shared.currentLanguage.locale.identifier)
        view?.setCurrentTime(dateFormatter.string(from: Date()))
    }
    
    func didTapStartReportingButton() {
        // TODO: Show reporting screen
        view?.showToastNotification(message: "Start Reporting button pressed")
    }
    

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
}

// MARK: - HomeInput

extension HomePresenter: HomeInput {
}
