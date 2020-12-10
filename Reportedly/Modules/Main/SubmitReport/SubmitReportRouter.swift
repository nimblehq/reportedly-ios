//
//  SubmitReportRouter.swift
//  Reportedly
//
//  Created by Minh Pham on 10/12/2020.
//  
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
