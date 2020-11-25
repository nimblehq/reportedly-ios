//
//  ToastView.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/17/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

final class ToastView: UIView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(.allCorners, radius: 8)
    }
}

// MARK: - Public Functions

extension ToastView {
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
}

// MARK: - Set Colors

extension ToastView {
    
    private func setUpColors() {
        backgroundColor = .forms
        titleLabel.textColor = .textPrimary
    }
}

// MARK: - Setup Views

extension ToastView {
    
    private func commonInit() {
        setUpLayouts()
        setUpViews()
        setUpColors()
    }
    
    private func setUpLayouts() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    private func setUpViews() {
        clipsToBounds = true
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
}
