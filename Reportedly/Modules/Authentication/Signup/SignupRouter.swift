//
//  SignupRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol SignupRouterInput: AnyObject {
    
    func popToRootViewController()
}

final class SignupRouter {

    weak var view: SignupViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SignupRouterInput

extension SignupRouter: SignupRouterInput {
    
    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
