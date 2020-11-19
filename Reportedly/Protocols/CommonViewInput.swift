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
}

extension CommonViewInput where Self: UIViewController {
    
    func showToastNotification(message: String) {
        ToastPresenter.shared.showNotification(message)
    }
}
