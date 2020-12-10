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
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func viewWillAppear() {
        let formattedDateString = Date().toString(withFormat: DateFormat.EEEE_MMMM_dd_YYYY)
        view?.setCurrentTime(formattedDateString)
        if let user = UserManager.shared.user {
            view?.setUser(user)
        }
    }
    
    func didTapStartReportingButton() {
        router.pushSubmitReportScreen()
    }
    
    func didTapMenuOptionReportHistoryButton() {
        router.pushReportsHistoryScreen()
    }
    
    func didTapMenuOptionChannelSubscriptionButton() {
        // TODO: Show channel subscription screen
        view?.showToastNotification(message: "Channel Subscription menu option pressed")
    }
    
    func didTapMenuOptionUserSettingsButton() {
        // TODO: Show user settings screen
        view?.showToastNotification(message: "User Settings menu option pressed")
    }
    
    func didTapMenuOptionLogoutButton() {
        // TODO: Logout the user and show login screen
        view?.showToastNotification(message: "Logout menu option pressed")
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
}

// MARK: - HomeInput

extension HomePresenter: HomeInput {
}
