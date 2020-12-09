//
//  CommonViewPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/17/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

final class CommonViewPresenter {
    
    static let shared = CommonViewPresenter(baseView: UIApplication.shared.windows.filter { $0.isKeyWindow }.first)
    
    private weak var baseView: UIView?
    private var loadingView: LoadingView?
    private var toastNotificationView: ToastView?
    
    private var dismissNotificationTimer: Timer?
    
    init(baseView: UIView?) {
        self.baseView = baseView
    }
    
    func hideLoadingView() {
        guard let baseView = baseView else { return log.error("No base view in CommonViewPresenter for presenting Toast!") }
        
        baseView.subviews.forEach { if $0 is LoadingView { $0.removeFromSuperview() } }
    }
    
    func showLoadingView(_ message: String) {
        guard let baseView = baseView else { return log.error("No base view in CommonViewPresenter for presenting Toast!") }
        
        if let loadingView = baseView.subviews.first(where: { $0 is LoadingView }) as? LoadingView {
            loadingView.text = message
        } else {
            baseView.addSubview(LoadingView(text: message))
        }
    }
    
    func showToastNotification(_ message: String, forTimeInterval interval: TimeInterval = 2.5) {
        guard let baseView = baseView else { return log.error("No base view in CommonViewPresenter for presenting Toast!") }
        
        // Clean up the active notification if any
        invalidateDismissNotificationTimer()
        removeCurrentToastNotification()
        
        // Setup a new notification
        let newNotificationView = ToastView()
        baseView.addSubview(newNotificationView)
        toastNotificationView = newNotificationView
        toastNotificationView?.titleLabel.textAlignment = .left
        toastNotificationView?.setTitle(message)
        
        toastNotificationView?.snp.makeConstraints {
            $0.width.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(baseView.snp.topMargin)
        }
        toastNotificationView?.layoutIfNeeded()
        
        // Hide the new notification beyond the top of the phone's screen
        let toastNotificationViewHeight = toastNotificationView?.bounds.height ?? 0
        toastNotificationView?.transform = .translation(y: -toastNotificationViewHeight)
        
        // Start show the new notification to the top region
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 4.0,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: { [weak self] in self?.toastNotificationView?.transform = .identity }
        )
        
        // Automatically dismiss the notification after the `interval
        Thread.executeOnMainThread { [weak self] in
            self?.dismissNotificationTimer = .scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] timer in
                self?.invalidateDismissNotificationTimer()
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    options: .curveEaseIn,
                    animations: { [weak self] in self?.toastNotificationView?.transform = .translation(y: -toastNotificationViewHeight) },
                    completion: { [weak self] _ in self?.removeCurrentToastNotification() }
                )
            }
        }
    }
    
    private func removeCurrentToastNotification() {
        toastNotificationView?.removeFromSuperview()
        toastNotificationView = nil
    }
    
    private func invalidateDismissNotificationTimer() {
        Thread.executeOnMainThread { [weak self] in
            self?.dismissNotificationTimer?.invalidate()
            self?.dismissNotificationTimer = nil
        }
    }
}
