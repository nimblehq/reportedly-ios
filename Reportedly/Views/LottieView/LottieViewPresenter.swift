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
    
    func showSuccessView(for duration: TimeInterval = 0.7, completion: EmptyCompletion? = nil) {
        guard successView == nil else { return log.error("There is a current success view showing, can't show another one.") }
        
        // Setup a new success view and display
        successView = SuccessView()
        successView?.presentViewOnTopWindow(for: 0.5) { [weak self] in
            completion?()
            self?.successView = nil
        }
    }
}
