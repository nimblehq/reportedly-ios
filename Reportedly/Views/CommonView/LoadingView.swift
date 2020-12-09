//
//  LoadingView.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

final class LoadingView: UIVisualEffectView {

    // MARK: - Private UI/UX Elements
    
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let blurEffect = UIBlurEffect(style: .light)
    private let messageLabel = UILabel()
    private let vibrancyView: UIVisualEffectView

    // MARK: - Public Variables
    
    var text: String? {
        didSet {
            messageLabel.text = text
        }
    }

    // MARK: - Init Functions
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Override Functions
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = self.superview else { return }
        let width = superview.frame.size.width / 2.3
        let height = CGFloat.spacer9
        self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                            y: superview.frame.height / 2 - height / 2,
                            width: width,
                            height: height)
        vibrancyView.frame = self.bounds
        let activityIndicatorSize: CGFloat = 40
        activityIndicator.frame = CGRect(x: 5,
                                        y: height / 2 - activityIndicatorSize / 2,
                                        width: activityIndicatorSize,
                                        height: activityIndicatorSize)
        messageLabel.frame = CGRect(x: activityIndicatorSize,
                             y: 0,
                             width: width - activityIndicatorSize - 15,
                             height: height)
    }
}

// MARK: - Set Colors

extension LoadingView {
    
    private func setUpColors() {
        messageLabel.textColor = .black
    }
}

// MARK: - Setup Views

extension LoadingView {
    
    private func commonInit() {
        setUpLayouts()
        setUpViews()
        setUpColors()
    }
    
    private func setUpLayouts() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(messageLabel)
    }
    
    private func setUpViews() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        
        activityIndicator.startAnimating()
        
        messageLabel.font = UIFont.appBoldFont(ofSize: .small)
        messageLabel.text = text
        messageLabel.textAlignment = .center
    }
}
