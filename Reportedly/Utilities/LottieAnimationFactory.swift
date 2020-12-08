//
//  LottieAnimationFactory.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Lottie
import UIKit

class LottieAnimationFactory {

    // MARK: - Public Constant
    static let shared = LottieAnimationFactory()

    /// disable the ability to init an instance of this type
    private init() { }

    // MARK: - Public Funtions
    func successView() -> AnimationView {
        let successView = AnimationView(name: "AnimatedSuccessCheck")
        successView.animationSpeed = 0.8
        successView.backgroundBehavior = .pauseAndRestore
        successView.play()
        return successView
    }
}
