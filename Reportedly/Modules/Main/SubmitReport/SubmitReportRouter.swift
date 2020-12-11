//
//  SubmitReportRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol SubmitReportRouterInput: AnyObject {
    
    func popViewController()
}

final class SubmitReportRouter {

    weak var view: SubmitReportViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SubmitReportRouterInput

extension SubmitReportRouter: SubmitReportRouterInput {
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
