//
//  ReportsHistoryRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol ReportsHistoryRouterInput: AnyObject {
    
    func popViewController()
}

final class ReportsHistoryRouter {

    weak var view: ReportsHistoryViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - ReportsHistoryRouterInput

extension ReportsHistoryRouter: ReportsHistoryRouterInput {
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
