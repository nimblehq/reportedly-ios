//
//  CommonViewInput.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol CommonViewInput {
    
    func showToastNotification(message: String)
    
    func showSuccessOverlayView(completion: EmptyCompletion?)
}

extension CommonViewInput where Self: UIViewController {
    
    func showSuccessOverlayView(completion: EmptyCompletion? = nil) {
        LottieViewPresenter.shared.showSuccessView(completion: completion)
    }
    
    func showToastNotification(message: String) {
        ToastPresenter.shared.showNotification(message)
    }
}
