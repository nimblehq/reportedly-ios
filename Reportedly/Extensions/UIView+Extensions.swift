//
//  UIView+Extensions.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

extension UIView {
    
    func fit(subView: UIView?, duration: TimeInterval = 0, completion: EmptyCompletion? = nil) {
        guard let subView = subView else { return }
        addSubview(subView)
        subView.snp.makeConstraints { $0.edges.equalTo(self) }
        guard duration > 0 else {
            completion?()
            return
        }
        subView.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            subView.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
    func presentViewOnTopWindow(_ duration: TimeInterval = 0.3, for dismissAfter: TimeInterval = 0, _ completion: EmptyCompletion? = nil) {
        alpha = 0
        frame = UIScreen.main.bounds
        let windows = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        windows?.addSubview(self)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = 1
        }, completion: { _ in
            if dismissAfter <= 0 {
                completion?()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) { [weak self] in
                     self?.dismissView(completion)
                }
            }
        })
    }
    
    func dismissView(with duration: TimeInterval = 0.3, _ completion: EmptyCompletion? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            completion?()
            self?.removeFromSuperview()
        })
    }
}
