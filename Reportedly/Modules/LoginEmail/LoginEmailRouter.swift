//
//  LoginEmailRouter.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol LoginEmailRouterInput {
    
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
        if let viewController = viewController {
            let navigationController = NavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            self.window = window
        }
    }
}
