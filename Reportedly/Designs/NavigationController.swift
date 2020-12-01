//
//  NavigationController.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpColors()
    }
    
    private func setUpColors() {
        navigationBar.tintColor = .primary
        view.backgroundColor = .clear
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setUpNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension NavigationController: UIAdaptivePresentationControllerDelegate {
    
    private var topAdaptivePresentationController: UIAdaptivePresentationControllerDelegate? {
        topViewController as? UIAdaptivePresentationControllerDelegate
    }
    
    @available(iOS 13.0, *)
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return topAdaptivePresentationController?.presentationControllerShouldDismiss?(presentationController)
            ?? true
    }
    
    @available(iOS 13.0, *)
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        topAdaptivePresentationController?.presentationControllerDidAttemptToDismiss?(presentationController)
    }
    
    @available(iOS 13.0, *)
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        topAdaptivePresentationController?.presentationControllerWillDismiss?(presentationController)
    }
    
    @available(iOS 13.0, *)
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        topAdaptivePresentationController?.presentationControllerDidDismiss?(presentationController)
    }
}
