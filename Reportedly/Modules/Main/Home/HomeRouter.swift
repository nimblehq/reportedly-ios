//
//  HomeRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol HomeRouterInput: AnyObject {
    
    func show(on window: UIWindow)
    func showLoginEmail()
    func pushReportsHistoryScreen()
    func pushSubmitReportScreen()
}

final class HomeRouter {

    weak var view: HomeViewInput?
    
    private var window: UIWindow?
    private var viewController: UIViewController? { view as? UIViewController }
}

// MARK: - HomeRouterInput

extension HomeRouter: HomeRouterInput {
    
    func show(on window: UIWindow) {
        guard let viewController = viewController else { return }
        let navigationController = NavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
    }
    
    func showLoginEmail() {
        guard let window = viewController?.view.window else { return }
        let module = LoginEmailModule()
        module.router.show(on: window)
    }
    
    func pushReportsHistoryScreen() {
        let module = ReportsHistoryModule()
        viewController?.navigationController?.pushViewController(module.view, animated: true)
    }
    
    func pushSubmitReportScreen() {
        let module = SubmitReportModule()
        viewController?.navigationController?.pushViewController(module.view, animated: true)
    }
}
