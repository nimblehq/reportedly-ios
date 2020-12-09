//
//  LoginEmailRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol LoginEmailRouterInput {
    
    func show(on window: UIWindow)
    func showHome()
    func pushSignupScreen()
}

final class LoginEmailRouter: LoginEmailRouterInput {
    
    private let urlOpener: URLOpener
    
    weak var view: LoginEmailViewInput?
    
    private var window: UIWindow?
    private var viewController: UIViewController? { view as? UIViewController }
    
    init(urlOpener: URLOpener) {
        self.urlOpener = urlOpener
    }
    
    func show(on window: UIWindow) {
        guard let viewController = viewController else { return }
        let navigationController = NavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
    }
    
    func showHome() {
        guard let window = viewController?.view.window else { return }
        let module = HomeModule()
        module.router.show(on: window)
    }

    func pushSignupScreen() {
        let module = SignupModule()
        viewController?.navigationController?.pushViewController(module.view, animated: true)
    }
}
