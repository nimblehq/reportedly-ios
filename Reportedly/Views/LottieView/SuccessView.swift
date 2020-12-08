//
//  SuccessView.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

class SuccessView: UIView {

    let containerView = UIView()
    let lottieSuccessView = LottieAnimationFactory.shared.successView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - Set Colors

extension SuccessView {
    
    private func setUpColors() {
        backgroundColor = .clear
    }
}

// MARK: - Setup Views

extension SuccessView {
    
    private func commonInit() {
        setUpLayouts()
        setUpColors()
    }
    
    private func setUpLayouts() {
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(containerView.snp.width)
        }
        
        containerView.addSubview(lottieSuccessView)
        
        lottieSuccessView.snp.makeConstraints { $0.edges.equalTo(containerView) }
    }
}
