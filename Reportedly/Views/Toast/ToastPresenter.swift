//
//  ToastPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/17/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol ToastPresenterDelegate: AnyObject {
    func showNotification(message: String)
}

final class ToastPresenter {
    
    static let shared = ToastPresenter(baseView: UIApplication.shared.windows.filter { $0.isKeyWindow }.first)

    private weak var baseView: UIView?
    private weak var notificationView: ToastView?
    private var currentMessage: String?
    private var currentNotificationMessage: String?

    init(baseView: UIView?) {
        self.baseView = baseView
    }

    func showNotification(
        _ message: String,
        forTimeInterval interval: TimeInterval = 2.5
    ) {
        guard let baseView = baseView else { return log.error("No base view in ToastPresenter!") }
        guard currentNotificationMessage != message else { return log.info("Same item is asked to be displayed!") }

        let newNotificationView = ToastView()
        newNotificationView.titleLabel.textAlignment = .left
        newNotificationView.setTitle(message)

        baseView.addSubview(newNotificationView)
        baseView.bringSubviewToFront(newNotificationView)

        newNotificationView.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(baseView.snp.topMargin)
        }

        currentNotificationMessage = message
        notificationView = newNotificationView
        newNotificationView.layoutIfNeeded()

        newNotificationView.transform = .translation(y: -newNotificationView.bounds.height)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 4.0,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: { newNotificationView.transform = .identity }
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            UIView.animate(
                withDuration: 0.24,
                delay: 0.0,
                options: .curveEaseIn,
                animations: { newNotificationView.transform = .translation(y: -newNotificationView.bounds.height) },
                completion: { _ in
                    newNotificationView.removeFromSuperview()
                    self.notificationView = nil
                    self.currentNotificationMessage = nil
                }
            )
        }
    }
}
