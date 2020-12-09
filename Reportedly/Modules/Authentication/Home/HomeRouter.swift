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
}
