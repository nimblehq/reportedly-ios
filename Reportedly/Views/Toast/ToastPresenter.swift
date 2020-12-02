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
    private var notificationView: ToastView?
    private var dismissNotificationTimer: Timer?
    
    init(baseView: UIView?) {
        self.baseView = baseView
    }
    
    func showNotification(_ message: String, forTimeInterval interval: TimeInterval = 2.5) {
        guard let baseView = baseView else { return log.error("No base view in ToastPresenter for presenting Toast!") }
        
        // Clean up the active notification if any
        invalidateDismissNotificationTimer()
        removeCurrentNotification()
        
        // Setup a new notification
        let newNotificationView = ToastView()
        baseView.addSubview(newNotificationView)
        notificationView = newNotificationView
        notificationView?.titleLabel.textAlignment = .left
        notificationView?.setTitle(message)
        
        notificationView?.snp.makeConstraints {
            $0.width.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(baseView.snp.topMargin)
        }
        notificationView?.layoutIfNeeded()
        
        // Hide the new notification beyond the top of the phone's screen
        let notificationViewHeight = notificationView?.bounds.height ?? 0
        notificationView?.transform = .translation(y: -notificationViewHeight)
        
        // Start show the new notification to the top region
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 4.0,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: { [weak self] in self?.notificationView?.transform = .identity }
        )
        
        // Automatically dismiss the notification after the `interval
        Thread.executeOnMainThread { [weak self] in
            self?.dismissNotificationTimer = .scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] timer in
                self?.invalidateDismissNotificationTimer()
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    options: .curveEaseIn,
                    animations: { [weak self] in self?.notificationView?.transform = .translation(y: -notificationViewHeight) },
                    completion: { [weak self] _ in self?.removeCurrentNotification() }
                )
            }
        }
    }
    
    private func removeCurrentNotification() {
        notificationView?.removeFromSuperview()
        notificationView = nil
    }
    
    private func invalidateDismissNotificationTimer() {
        Thread.executeOnMainThread { [weak self] in
            self?.dismissNotificationTimer?.invalidate()
            self?.dismissNotificationTimer = nil
        }
    }
}
