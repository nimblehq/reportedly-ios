//
//  LabelLinkView.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/17/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol LabelLinkViewDelegate: AnyObject {
    
    func labelWithLinkViewDidTapLink(_ linkView: LabelWithLinkView)
}

final class LabelWithLinkView: UIView {
    
    private let labelLinkStackView = UIStackView()
    private let label = UILabel()
    private let linkButton = UIButton(type: .system)
    
    weak var delegate: LabelLinkViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(labelLinkStackView)
        labelLinkStackView.addArrangedSubview(label)
        labelLinkStackView.addArrangedSubview(linkButton)
        
        labelLinkStackView.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.height.equalTo(CGFloat.spacer8)
        }
        
        setUpLabelLinkStackView()
        setUpLabel()
        setUpLinkButton()
    }
    
    private func setUpLabelLinkStackView() {
        labelLinkStackView.axis = .horizontal
        labelLinkStackView.spacing = .spacer1
    }
    
    private func setUpLabel() {
        label.font = UIFont.appFont(ofSize: .xSmall)
        label.textColor = .textPrimary
    }
    
    private func setUpLinkButton() {
        linkButton.addTarget(self, action: #selector(didTapLinkButton), for: .touchUpInside)
    }
}

// MARK: - Public Functions

extension LabelWithLinkView {
    
    func setText(labelText: String, linkText: String) {
        label.text = labelText
        let linkButtonTitle = NSAttributedString(
            string: linkText,
            attributes: [
                .foregroundColor: UIColor.textHighlighted,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.appFont(ofSize: .xSmall)
            ]
        )
        linkButton.setAttributedTitle(linkButtonTitle, for: .normal)
    }
    
    func setLabelText(_ labelText: String) {
        label.text = labelText
    }
    
    func setLinkText(_ linkText: String) {
        let linkButtonTitle = NSAttributedString(
            string: linkText,
            attributes: [
                .foregroundColor: UIColor.textHighlighted,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.appBoldFont(ofSize: .xSmall)
            ]
        )
        linkButton.setAttributedTitle(linkButtonTitle, for: .normal)
    }
    
    func setLinkButtonHidden(_ isHidden: Bool) {
        linkButton.isHidden = isHidden
    }
}

// MARK: - Actions

extension LabelWithLinkView {
    
    @objc private func didTapLinkButton() {
        delegate?.labelWithLinkViewDidTapLink(self)
    }
}
