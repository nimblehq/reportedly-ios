//
//  CommonViewInput.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol CommonViewInput {
    
    func hideLoadingView()
    
    func showLoadingView(message: String)
    
    func showSuccessOverlayView(completion: EmptyCompletion?)
    
    func showToastNotification(message: String)
}

extension CommonViewInput where Self: UIViewController {
    
    func hideLoadingView() {
        CommonViewPresenter.shared.hideLoadingView()
    }
    
    func showLoadingView(message: String) {
        CommonViewPresenter.shared.showLoadingView(message)
    }
    
    func showSuccessOverlayView(completion: EmptyCompletion? = nil) {
        LottieViewPresenter.shared.showSuccessView(completion: completion)
    }
    
    func showToastNotification(message: String) {
        CommonViewPresenter.shared.showToastNotification(message)
    }
}
