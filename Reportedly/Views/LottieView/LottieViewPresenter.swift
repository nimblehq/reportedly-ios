//
//  LottieViewPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol LottieViewPresenterDelegate: AnyObject {
    
    func showSuccessView()
}

final class LottieViewPresenter {
    
    static let shared = LottieViewPresenter()
    
    private var successView: SuccessView?
    
    func showSuccessView(for duration: TimeInterval = 1.5, completion: EmptyCompletion? = nil) {
        
        // Setup a new success view and display
        successView = SuccessView()
        successView?.presentViewOnTopWindow(for: duration) { [weak self] in
            completion?()
            self?.successView = nil
        }
    }
}
