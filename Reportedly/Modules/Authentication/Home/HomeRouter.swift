//
//  HomeRouter.swift
//  Reportedly
//
//  Created by Minh Pham on 09/12/2020.
//  
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
